clc;
clear all;

SNR =5.25;
frame =  1; 
Marray= 4;
M= log2(Marray);

iter_LDPC =50;
Ebo=[];
Ber0=[];

load Hs1-2(4-9){1-60}.mat
load Gs1-2(4-9){1-60}.mat

[p n] = size(H);

k = n-p;

while true
ber=0;   
fprintf('SNR: %d\n', SNR);
snr= 10.^(SNR/10);
sigma = sqrt(1./(2*snr));

 for jj=1:frame
        information = randi([0,1], 1, k);%generate info
        codeword = mod(information*G,2); 

        [out_simbol,code_bit,code_simbol]=mapper(codeword,'qpsk');
        
        Hk=1;%kanal sempurna
        noise= sigma*(randn(length(out_simbol),1) + sqrt(-1)*randn(length(out_simbol),1));%noise
        rx1 = (Hk.*out_simbol) + noise;

        [Lci]=soft_demapper_QPSK(rx1,code_bit,code_simbol,sigma);
%         [Lci]=soft_demapper_BPSK(rx1,code_bit,code_simbol,sigma);
%         kumpullci=[kumpullci Lci];
%            Lci = real(rx1);

%EXIT
          Figure1=figure(1); 
          
          axes1 = axes('Parent',Figure1);
% hold(axes1,'on');

legend1 = legend(axes1,'show');
set(legend1,'Location','northeast');

%           IA_ch = measure_MI_histogram(Lci,codeword);
          IA_ch = 0.6613;

          
          EXIT_LDPC_AWGN_coba(IA_ch);
          hold on;
          EXIT_CND_DVB_acc(IA_ch);
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
          


%           u_C_I=H(:,1:k).*repmat(information+1, p, 1);
% %           [r4 pc4 u_C_Info]= find (u_C_I);  
%           u_C_C=H.*repmat(codeword+1, p, 1);
%           [r4 pc4 u_C_Core]= find (u_C_C);
         
            %PROSES ITERATIVE DECODING
%                  La_ext_to_LDPC= zeros(1,n);
%                  La_vnd_LDPC= zeros(1,n);

                 Lrji= zeros(p,n);
        
%            for gg=1:globaliter

                     %LDPC codes iterative decoding    
%                 [berper,Lqij,Lrji,hatb, iter, miC, miV]= decode_LDPC_2310_exit(Lrji,Lci,H,iter_LDPC,information,k,u_C_I,u_C_C);
        [berper,Lrji,hatb, iter] = decode_LDPC_2310(Lrji,Lci,H,iter_LDPC,information,k);


%                   [La_vnd_LDPC, Lqij_LC, Lrji_LC, hatb, iter]= decode_LDPC_5GNR1(Lrji_LC, Lci(1,1:n), H, iter_LDPC);
                     
%                 [r4 pc4 Lrji_LDPC]=find(Lrji);
%                 miC(gg)=measure_MI_histogram(Lrji_LDPC,u_C_Core-1);
%                 

                  
%                         
%                 [r4 pc4 Lqij_LDPC]=find(Lqij(:,1:k));
%                 miV(gg)=measure_MI_histogram(Lqij_LDPC,u_C_Info-1);
%            end           
         ber = ber+berper;
        if berper~=0
            fprintf('frame =%g, ber=%d, iter=%d \n ', jj, berper, iter);
        else
            fprintf('frame =%g, ber=%d, iter=%d \n ', jj, berper, iter);
        end%Count number of errors;
                       
   
%Penghitungan BER
% for ii=1:length(Lci)
%             if Lci(ii)>=0
%                 bit_de(ii) = 0;
%             else
%                 bit_de(ii) = 1;
%             end
% end
        
        %BER & FER Calculations
%         compare_bit = sum(bit_de~=information);
%         BER = BER+compare_bit;
%         if compare_bit~=0
%             fer = fer+1;
%         end

% miVtemp=miV+miVtemp;
% miCtemp=miC+miCtemp;

end %iterframe

%     IA_ch = measure_MI_histogram(kumpullci,kumpulcode);
%     EXIT_CND_DVB_cb(IA_ch);
%     hold on;
%     EXIT_VND_DVB_cb(IA_ch);
%     axis([0 1 0 1]);
    
%     [IAn, IEn]= draw_trajectory(miC,miV); 
%     axis([0 1 0 1]);

    if (SNR==2.25)
        eBER=ber/(frame*k);
        Ber0=[Ber0 eBER];
        Ebo=[Ebo SNR];
       break;
   else 
        eBER=ber/(frame*k);
        Ber0=[Ber0 eBER];
        Ebo=[Ebo SNR];
        SNR=SNR+1;
    end
    fprintf('BER=%d, \n', ber);
    
    
    
    
end

Figure1=figure(1); 
FigW=6; 
FigH=5.6; 
ylabel({'IE_VND,IA_CND'});
xlabel({'IA_VND,IE_CND'});

set(Figure1,'defaulttextinterpreter','latex',... 
    'PaperUnits','inches','Papersize',[FigW,FigH],... 
    'Paperposition',[0,0,FigW,FigH],'Units','Inches',... 
    'Position',[0,0,FigW,FigH]) 
set(gca,... 
    'FontSize',10,... 
    'FontName','Arial');       

% Create xlabel

Figure1=figure(1); 
FigW=6; 
FigH=5.6; 
set(Figure1,'defaulttextinterpreter','latex',... 
    'PaperUnits','inches','Papersize',[FigW,FigH],... 
    'Paperposition',[0,0,FigW,FigH],'Units','Inches',... 
    'Position',[0,0,FigW,FigH]) 
set(gca,... 
    'FontSize',10,... 
    'FontName','Arial');  
%  semilogy(Ebo,Ber0, '*-', 'linewidth',1);
% xlabel('EBN(dB)');
% ylabel('BER');

% figure(1); 
% semilogy(SNRdB,BER1,'-x');
% Figure1=figure(1); 
% FigW=6; 
% FigH=5.6; 
% set(Figure1,'defaulttextinterpreter','latex',... 
%     'PaperUnits','inches','Papersize',[FigW,FigH],... 
%     'Paperposition',[0,0,FigW,FigH],'Units','Inches',... 
%     'Position',[0,0,FigW,FigH]) 
% set(gca,... 
%     'FontSize',10,... 
%     'FontName','Arial');        