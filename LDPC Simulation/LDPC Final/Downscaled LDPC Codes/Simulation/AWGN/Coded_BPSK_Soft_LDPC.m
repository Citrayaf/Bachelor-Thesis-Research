clear all
clc

Modulasi = 2;
indeks_modulasi=log2(Modulasi);

frame= 25;
iter_LDPC=5;

load Hs1-2(4-9){1-60}.mat
load Gs1-2(4-9){1-60}.mat


SNR=0;

[p n] = size(H);
k = n-p;


% for ii=1:length(SNR)
    snr=10.^(SNR/10);
%     snr=10.^(SNR(ii)/10);
    
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

