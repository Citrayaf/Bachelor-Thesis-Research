clear all
clc


Modulasi = 4;
indeks_modulasi=log2(Modulasi);

frame= 500;

iter_LDPC=5;

load Hs1-2(4-9){1-60}.mat
load Gs1-2(4-9){1-60}.mat

 dvi = sum(H,1);           % <-- to sum up the dc and dv
 dci = sum(H,2)';

[p n] = size(H);
k = n-p; %information

SNR=0;


% for ii=1:length(SNR)
    snr=10.^(SNR/10);
%     snr=10.^(SNR(ii)/10);
    
    sigma = sqrt(1./(2*snr));
    
    jum_error = 0;
    
    for i=1:frame
        bit_informasi = randi([0 1], 1, k);
        codeword = mod(bit_informasi*G,2); 

        
        code=mapper(codeword,'qpsk');
        
        %make the dimension same with the noise dimension
        x = code.';
        
        h=1;
        
        noise=sigma*(randn(1,length(x)) + sqrt(-1)*randn(1,length(x)));
        
        y=h*x+noise;
        

        u=Softdemapper_manualQ(y,sigma); 
        
%       %======================EXIT==========================================
        
        Figure1=figure(1); 
          
        axes1 = axes('Parent',Figure1);
        % hold(axes1,'on');

        legend1 = legend(axes1,'show');
        set(legend1,'Location','northeast');

        IA_ch = measure_MI_histogram(u,codeword);
%       IA_ch = 0.6613;

          
        EXIT_CND_DVB_1_2(IA_ch, H);
        hold on;
        EXIT_VND_DVB_1_2(IA_ch);
        axis([0 1 0 1]);
          
        FigW=6; 
        FigH=5.6; 
        ylabel({'IE_{VND},IA_{CND}'});
        xlabel({'IA_{VND},IE_{CND}'});



        set(Figure1,'defaulttextinterpreter','latex',... 
            'PaperUnits','inches','Papersize',[FigW,FigH],... 
            'Paperposition',[0,0,FigW,FigH],'Units','Inches',... 
            'Position',[0,0,FigW,FigH]) 
        set(gca,... 
            'FontSize',10,... 
            'FontName','Arial');       
        box(axes1,'on');        


%       =====================================================================
        
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

semilogy(SNR,berplot,'-*','linewidth',1)

