clear all
clc

info = 120;

Modulasi = 2;
indeks_modulasi=log2(Modulasi);

frame= 250;

SNR=0:1:30;


for ii=1:length(SNR)
%     snr=10.^(SNR/10);
    snr=10.^(SNR(ii)/10);
    
    sigma = sqrt(1./(2*snr));
    
    jum_error = 0;
    
    for i=1:frame
        bit_informasi = randi([0 1], 1, info);
        
        x=1-bit_informasi*2;
        
        h=(randn(1,1)+sqrt(-1)*randn(1,1))/sqrt(2);%singlepath channel
        
        noise=sigma*(randn(1,length(x)) + sqrt(-1)*randn(1,length(x)));
        
        y=h*x+noise;
        
%         ==================================================================
        
        %Zero Forcing Equalization
        y_ZF = y/h;
        
        y_final = y_ZF;

%         ==================================================================

        %MMSE Equalization
%         w = conj(h)/(h*conj(h)+(1/snr));
%         y_MMSE = y*w;
%         
%         y_final = y_MMSE;
        
%         u=(2/sigma^2)*real(y_final);%soft Demapper
        
        u = real(y_final);%hard demapper
        
        for j=1:length(u)
            if u(j)>0
                b(j)=0;
            else
                b(j)=1;
            end
        end
        
        error = sum(b~=bit_informasi); 
        
        jum_error=jum_error+error;
        
    end
    
    ber=jum_error/(info*frame);
    
    berplot(ii)=ber;
    
end

semilogy(SNR,berplot,'-*','linewidth',1)

