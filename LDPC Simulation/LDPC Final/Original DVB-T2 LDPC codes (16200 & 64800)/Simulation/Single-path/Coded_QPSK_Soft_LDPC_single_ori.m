clear all
clc


Modulasi = 4;
indeks_modulasi=log2(Modulasi);

frame= 5;

iter_LDPC=5;

load Hr=1-2.mat
load Gr=1-2.mat

[p n] = size(H);
k = n-p; %information

SNR=0:5:30;


for ii=1:length(SNR)
%     snr=10.^(SNR/10);
    snr=10.^(SNR(ii)/10);
    
    sigma = sqrt(1./(2*snr));
    
    jum_error = 0;
    
    for i=1:frame
        bit_informasi = randi([0 1], 1, k);
        codeword = mod(bit_informasi*G,2); 

        
        code=mapper(codeword,'qpsk');
        
        %make the dimension same with the noise dimension
        x = code.';
        
        h=(randn(1,1)+sqrt(-1)*randn(1,1))/sqrt(2);%singlepath channel;
        
        noise=sigma*(randn(1,length(x)) + sqrt(-1)*randn(1,length(x)));
        
        y=h*x+noise;
        
%       MMSE Equalization
        w = conj(h)/(h*conj(h)+(1/snr));
        y_MMSE = y*w;
        
        y_final = y_MMSE;        

        u=Softdemapper_manualQ(y_final,sigma); 
        
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

