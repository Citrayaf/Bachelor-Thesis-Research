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

FFTSize = 256; %Amount of information bit is same with FFT size in OFDM
N = FFTSize*indeks_modulasi;  %amount of bit

SNR=0:5:30;

frame= 150;

F = dftmtx(FFTSize)/sqrt(FFTSize);  %FFT
Fh = F';  %IFFT

ptop = FFTSize+cp_len*2;
pdat = cp_len+FFTSize;

%LDPC 
iter_LDPC =50;
load Hs1-2(4-9){1-60}.mat
load Gs1-2(4-9){1-60}.mat
load Gs5-6(37-45){1-60}.mat
load Hs5-6(37-45){1-60}.mat
[p n] = size(H);
k = n-p;

Check = N-n;    % Check value of N to fill up FFT size A.K.A Dummy

for ii=1:length(SNR)
%     snr=10.^(SNR/10);
    snr=10.^(SNR(ii)/10);
    
    sigma = sqrt(1./(2*snr));
    
    jum_error = 0;
    
    for i=1:frame
        bit_informasi = randi([0 1], 1, k);
        
        c=mod(bit_informasi*G,2); %LDPC encoding
        
        %adding Dummy
        s=zeros(1,(Check));
        for j=1:(Check)
            s(:,1)=0;
        end
        c_wdum=[c s];

        
        code=mapper(c_wdum,'qpsk');
        
        x=code.';
        
        %Inisialisasi OFDM
        %IFFT
        out_ifft = ifft(x)*sqrt(length(x));
       
        %Add CP
        out_ifft_cp = [out_ifft(end-cp_len+1:end) out_ifft];
        
        %Kanal Fading H
        for jj=1:path_len
             H_ch(jj)=h(jj)*(randn(1,1) + sqrt(-1)*randn(1,1))/sqrt(2);
             %multipath
        end
        
        %Toeplitz
        h_T = zeros(ptop-1,pdat);
        for iii=1:pdat
            for jjj=1:path_len
                h_T(jjj+iii-1,iii) = H_ch(jjj);
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
        Heq = circulant([H_ch zeros(1,FFTSize-path_len)]);
        psi = F*Heq*Fh;
        psi_val = diag(psi);        
        %Buat LDPC
        Z= out_fft.*conj(psi_val);
        
        
%         ====================================================================

        u_dum=Softdemapper_manualQ(Z.',sigma);
        
        u  = u_dum(1:(n));%pelepasan dummy

%       Decoding LDPC
        Lrji= zeros(p,n);
        
        [error,Lrji,hatb, iter] = decode_LDPC_2310(Lrji,u,H,iter_LDPC,bit_informasi,k); %SPA
                     
%         [error,Lrji,hatb, iter] = decode_LDPC_MinSum(Lrji,u,H,iter_LDPC,bit_informasi,k); %Min-Sum               

        % fprintf('frame =%g, ber=%d\n', jj, ber);
        fprintf('frame =%g, ber=%d, iter=%d\n ', i, error, iter);
        
        jum_error=jum_error+error;
        
    end
    
    ber=jum_error/(k*frame);
    
    berplot(ii)=ber;
    
end

semilogy(SNR,berplot,'-*','linewidth',1)

