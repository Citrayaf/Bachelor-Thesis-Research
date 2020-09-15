clear all
clc

input=[1 0.17735768	0.058438626	0.018028102	0.006311026	0.002133536	0.000500726	0.000208978];%Bandung

path_len = length(input);  %amount of paths
for mm=1:path_len
    h(mm) = sqrt(input(mm));
end

% cp_len = ceil((4.69/66.67)*FFTSize);  %numerology 0 yang digunakan pada 5G

cp_len = 8;


Modulasi = 2;
indeks_modulasi=log2(Modulasi);

FFTSize = 512; %Amount of information bit is same with FFT size in OFDM
N = FFTSize*indeks_modulasi;  %amount of bit

SNR=5:5:10;

frame= 2;

F = dftmtx(FFTSize)/sqrt(FFTSize);  %FFT
Fh = F';  %IFFT

ptop = FFTSize+cp_len*2;
pdat = cp_len+FFTSize;

%LDPC 
iter_LDPC =5;
load Hr=1-2.mat
load Gr=1-2.mat
[p n] = size(H);
k = n-p;

%Slicing
slicing_loop = n/N;
loopz = ceil(slicing_loop);
Check = (N*loopz)-n;% Check value of N to fill up FFT size A.K.A Dummy
loopa = floor(slicing_loop);

%Toeplitz
h_T = zeros(ptop-1,pdat);


for ii=1:length(SNR)
%     snr=10.^(SNR/10);
    snr=10.^(SNR(ii)/10);
    
    sigma = sqrt(1./(2*snr));
    
    jum_error = 0;
    
    for i=1:frame
        bit_informasi = randi([0 1], 1, k);
        
        u=[];
        
        c=mod(bit_informasi*G,2); %LDPC encoding
        
        for sx=1:loopz
                if sx==1
                    pot{1,sx}=c(1,1:N);
                else
                    sd=sx*N;
                    sa=((sx-1)*N)+1;
                    if sx==32
                        sa=(loopa*N)+1;
                        sd=n;
                    end                  
                   pot{1,sx}=c(1, sa:sd); 
                end
        end
        
        %adding Dummy
        s=zeros(1,(Check));
        cd=[pot{1,32} s];
        pot{1,32}=cd;
        
        %Fading Channel H
        for jj=1:path_len
             H_ch(jj)=h(jj)*(randn(1,1) + sqrt(-1)*randn(1,1))/sqrt(2);
             %multipath
        end
        

        for iii=1:pdat
            for jjj=1:path_len
                h_T(jjj+iii-1,iii) = H_ch(jjj);
            end
        end
        
        for jx=1:loopz
        
            x=1-pot{1,jx}*2;

            %Inisialisasi OFDM
            %IFFT
            out_ifft = ifft(x)*sqrt(length(x));

            %Add CP
            out_ifft_cp = [out_ifft(end-cp_len+1:end) out_ifft];

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

            u_dum=(2/sigma^2)*real(Z.');%soft Demapper
    
            last = N-Check;
            if jx==loopz
                u_dum = u_dum(1:last);%dummy remover
            end
            
            u = [u u_dum];
            
        end

%       Decoding LDPC
        Lrji= zeros(p,n);

        [error,Lrji, hatb, iter] = decode_LDPC_2310(Lrji, u, H, iter_LDPC, bit_informasi, k); %SPA

%         [error,Lrji,hatb, iter] = decode_LDPC_MinSum(Lrji,u,H,iter_LDPC,bit_informasi,k); %Min-Sum               

        % fprintf('frame =%g, ber=%d\n', jj, ber);
        fprintf('frame =%g, ber=%d, iter=%d\n ', i, error, iter);

        jum_error=jum_error+error;
        
        
    end
    
    ber=jum_error/(k*frame);
    
    berplot(ii)=ber;
    
end

semilogy(SNR,berplot,'-*','linewidth',1)

