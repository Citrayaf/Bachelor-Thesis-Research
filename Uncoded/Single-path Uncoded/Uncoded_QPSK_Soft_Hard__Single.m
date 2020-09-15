clear all
clc

info = 100;

Modulasi = 4;
indeks_modulasi=log2(Modulasi);

frame= 500;

SNR=0:1:30;


for ii=1:length(SNR)
%     snr=10.^(SNR/10);
    snr=10.^(SNR(ii)/10);
    
    sigma = sqrt(1./(2*snr));
    
    jum_error = 0;
    
    for i=1:frame
        bit_informasi = randi([0 1], 1, info);
        
        code=mapper(bit_informasi,'qpsk');
        
        %make the dimension same with the noise dimension
        x = code.';
        
        h=(randn(1,1)+sqrt(-1)*randn(1,1))/sqrt(2);%singlepath channel
        
        noise=sigma*(randn(1,length(x)) + sqrt(-1)*randn(1,length(x)));
        
        y=h*x+noise;
        
%         y_final=y;
        
%         ==================================================================
        
        %Zero Forcing Equalization
%         y_ZF = y/h;
%         
%         y_final = y_ZF;

%         ==================================================================

%         %MMSE Equalization
%         w = conj(h)/(h*conj(h)+(1/snr));
%         y_MMSE = y*w;
%         
%         y_final = y_MMSE;
        
%         =================================================
                
%         =================================================================
        
%         u=HardDemapperQ_tanpa_batas(y_final);
%                 
%         error = sum(u~=bit_informasi); %Hard Demapper
%         
%         ====================================================================

        u=Softdemapper_manualQ(y_final,sigma); 
        
        for j=1:length(u)
            if u(j)>0
                b(j)=0;
            else
                b(j)=1;
            end
        end
        
        error = sum(b~=bit_informasi); %soft Demapper
        
        jum_error=jum_error+error;
        
    end
    
    ber=jum_error/(info*frame);
    
    berplot(ii)=ber;
    
end

semilogy(SNR,berplot,'-*','linewidth',1)

