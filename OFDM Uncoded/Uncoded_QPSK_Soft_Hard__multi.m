clear all
clc

input=[1 0.17735768	0.058438626	0.018028102	0.006311026	0.002133536	0.000500726	0.000208978];%Bandung

path_len = length(input);  %amount of paths
for mm=1:path_len
    h(mm) = sqrt(input(mm));
end

% cp_len = ceil((4.69/66.67)*FFTSize);  %numerology 0 yang digunakan pada 5G

cp_len = 8;


Modulasi = 4;
indeks_modulasi=log2(Modulasi);

R = 1;
FFTSize = 256; %Amount of information bit is same with FFT size in OFDM
N = FFTSize*indeks_modulasi;  %amount of bit
K   = R*N;

SNR=0:1:30;

frame= 250;

F = dftmtx(FFTSize)/sqrt(FFTSize);  %FFT
Fh = F';  %IFFT

ptop = FFTSize+cp_len*2;
pdat = cp_len+FFTSize;


for ii=1:length(SNR)
%     snr=10.^(SNR/10);
    snr=10.^(SNR(ii)/10);
    
    sigma = sqrt(1./(2*snr));
    
    jum_error = 0;
    
    for i=1:frame
        bit_informasi = randi([0 1], 1, N);
        
        code=mapper(bit_informasi,'qpsk');
        
        x=code.';
        
        %Inisialisasi OFDM
        %IFFT
        out_ifft = ifft(x)*sqrt(length(x));
       
        %Add CP
        out_ifft_cp = [out_ifft(end-cp_len+1:end) out_ifft];
        
        %Kanal Fading H
        for jj=1:path_len
             H(jj)=h(jj)*(randn(1,1) + sqrt(-1)*randn(1,1))/sqrt(2);
             %multipath
        end
        
        %Toeplitz
        h_T = zeros(ptop-1,pdat);
        for iii=1:pdat
            for jjj=1:path_len
                h_T(jjj+iii-1,iii) = H(jjj);
            end
        end
        
        %Adding Noise
        y_cp = h_T*out_ifft_cp.';
        noise = sigma*(randn(length(y_cp),1)+sqrt(-1)*randn(length(y_cp),1));
        y_cpn = y_cp+noise;  
        %y=hx+n
        
        %Remove CP
        y = y_cpn(cp_len+1:end-cp_len+1);
        
        %FFT
        out_fft = fft(y)/sqrt(length(y));
        
        %Channel Equalization
        Heq = circulant([H zeros(1,FFTSize-path_len)]);
        psi = F*Heq*Fh;
        psi_val = diag(psi);
        Z = out_fft.*conj(psi_val)./(psi_val.*conj(psi_val)+sigma^2);
        
        %Buat LDPC
%         a=out_ifft.';
%         Z= a.*conj(psi_val);
        
%         =================================================================
        
        u=HardDemapperQ_tanpa_batas(Z.');
                
        error = sum(u~=bit_informasi); %Hard Demapper
%         
%         ====================================================================

%         u=Softdemapper_manualQ(Z.',sigma); 
%         
%         for j=1:length(u)
%             if u(j)>0
%                 b(j)=0;
%             else
%                 b(j)=1;
%             end
%         end
%         
%         error = sum(b~=bit_informasi); %soft Demapper
        
        jum_error=jum_error+error;
        
    end
    
    ber=jum_error/(N*frame);
    
    berplot(ii)=ber;
    
end

semilogy(SNR,berplot,'-*','linewidth',1)

