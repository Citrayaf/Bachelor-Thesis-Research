clc;
clear all;

SNR = 15;
frame = 7500;
Marray= 2;
M= log2(Marray);


iter_LDPC =50;
Ebo=[];
Ber0=[];
Hasilber=[];
% load acak1_2.mat
% load geneacak.mat

load Hs1-2(4-9){1-60}.mat
load Gs1-2(4-9){1-60}.mat

% load PEGH4-9.mat
% load PEGG4-9.mat


info=120;
[p n] = size(H);
k = n-p;



BER=0;
fprintf('SNR: %d\n', SNR);
snr= 10.^(SNR/10);
sigma = sqrt(1./(2*snr));



for jj=1:frame
    d=[];
    
    
    information = randi([0,1], 1, info);%generate info
    codeword = mod(information*G,2);
    
    %     codeword = information;
    
    
    out_simbol = 1-2*codeword;%mapper BPSK
    
    Hk=(randn(1,1)+sqrt(-1)*randn(1,1))/sqrt(2);%kanal singlepath
    noise= sigma*(randn(1,length(out_simbol)) + sqrt(-1)*randn(1,length(out_simbol)));%noise
    rx1 = (Hk.*out_simbol) + noise;%penambahan noise
    
    %         rx2 = rx1.*conj(Hk)./(Hk.*conj(Hk)+sigma^2);
    
    rx2 = rx1.*conj(Hk);
    
    
    
    [Lci] = (2/sigma^2)*real(rx2);
    
    
    
    %PROSES ITERATIVE DECODING
    %
    
    Lrji= zeros(p,n);
    
    
    %
    [ber,Lrji,hatb, iter] = decode_LDPC_terbaik(Lrji,Lci,H,iter_LDPC,information,k);
    
    %         for kk=1:length(Lci)
    %             if Lci(kk)>0
    %                 d=[d 0];
    %             else
    %                 d=[d 1];
    %             end
    %         end
    %
    %         ber=sum(abs(d-information));
    
    
    BER=BER+ber;
    fprintf('frame =%g, ber=%d\n', jj, ber);
    %         fprintf('frame =%g, ber=%d, iter=%d\n ', jj, ber, iter);
    
    
end %iterframe

fprintf('Ber total=%d Ber beneran=%d \n ',BER, BER/(frame*info));

% semilogy(Ebo,Ber0, '*-', 'linewidth',1);
% % xlabel('EBN(dB)');
% % ylabel('BER');
%
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
% ylabel({'BER'});

% Create xlabel
% xlabel({'SNR (dB)'});