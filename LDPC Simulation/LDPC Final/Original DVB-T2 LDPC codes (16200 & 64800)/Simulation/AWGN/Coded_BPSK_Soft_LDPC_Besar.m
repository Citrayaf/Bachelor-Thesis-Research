clear all
clc

%Note, Run this in high spec CPU because the size of LDPC codes is too big
%so the computation time will take so long.

Modulasi = 2;
indeks_modulasi=log2(Modulasi);

frame= 2;
iter_LDPC=5;

load Hr=1-2.mat
load Gr=1-2.mat

SNR=0;

[p n] = size(H);
k = n-p;


% for ii=1:length(SNR)
    snr=10.^(SNR/10);
%     snr=10.^(SNR(ii)/10);

% frame adjusted to the SNR
% if SNR <= 0.2
%     frame=50;
% else
%     if SNR > 0.2 && SNR <= 0.4
%         frame=50;
%     else
%         if SNR > 0.4 && SNR <= 1
%             frame=50;
%         else
%             if SNR > 3 && SNR <= 4
%                 frame=50;
%                 else
%                     if SNR > 4 && SNR <= 6
%                         frame=50;
%                     else
%                         if SNR > 25 && SNR <= 30
%                             frame=50;
%                         end
%                     end
%              end
%         end
%      end
% end
    
    sigma = sqrt(1./(2*snr));
    
    jum_error = 0;
    
    for i=1:frame
        bit_informasi = randi([0 1], 1, k);
        codeword = mod(bit_informasi*G,2); 

        
        x=1-codeword*2;
        
        h=1;
        
        noise=sigma*(randn(1,length(x)) + sqrt(-1)*randn(1,length(x)));
        
        y=h*x+noise;
        
        u=(2/sigma^2)*real(y);%soft Demapper
        
%       Decoding LDPC
        Lrji= zeros(p,n);
        
        [error,Lrji,hatb, iter] = decode_LDPC_2310(Lrji,u,H,iter_LDPC,bit_informasi,k); %SPA
                     
%         [error,Lrji,hatb, iter] = decode_LDPC_MinSum(Lrji,u,H,iter_LDPC,bit_informasi,k); %Min-Sum               

        % fprintf('frame =%g, ber=%d\n', jj, ber);
        fprintf('frame =%g, ber=%d, iter=%d\n ', i, error, iter);
        
        jum_error=jum_error+error;
        
    end
    
    ber=jum_error/(k*frame);
    
%     berplot(ii)=ber;
    
% end

% semilogy(SNR,berplot,'-b*','linewidth',1)

