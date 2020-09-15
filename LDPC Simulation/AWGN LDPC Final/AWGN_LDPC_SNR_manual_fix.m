clc;
clear all;

SNR =7;
frame =55500; 
Marray= 4;
M= log2(Marray);
% r=4/5;

out_simbol=[];

iter_LDPC =50;
% Ebo=[];
% Ber0=[];
% Hasilber=[];

load Hs1-2(4-9){1-60}.mat
load Gs1-2(4-9){1-60}.mat

info=270;
[p n] = size(H);
k = n-p;


% while true
BER=0;   
fprintf('SNR: %d\n', SNR);
snr= 10.^(SNR/10);
sigma = sqrt(1./(2*snr));

% if SNR <= 5
%     frame=1;
% else
%     if SNR > 5 && SNR <= 10
%         frame=350;
%     else
%         if SNR > 10 && SNR <= 15
%             frame=400;
%         else
%             if SNR > 15 && SNR <= 20
%                 frame=800;
%                 else
%                     if SNR > 20 && SNR <= 25
%                         frame=1200;
%                     else
%                         if SNR > 25 && SNR <= 30
%                             frame=1600;
%                         end
%                     end
%              end
%         end
%      end
% end

 for jj=1:frame
     Lci=[];
out_simbol=[];

        information = randi([0,1], 1, k);%generate info
        codeword = mod(information*G,2); 
        
%         out_simbol = 1-2*codeword;%mapper BPSK
          codeworda=codeword(1:length(codeword)/2);
          codeworda(codeworda==1)=-1;
          codeworda(codeworda==0)=1;

          codewordb=codeword(length(codeword)/2+1:length(codeword));
          codewordb(codewordb==1)=-1;
          codewordb(codewordb==0)=1;
          

%           for kil=1:length(codeworda)
%               hasil=codeworda(kil)/sqrt(2)+(codewordb(kil)*sqrt(-1))/sqrt(2);
%               out_simbol = [out_simbol hasil];
%           end
          hasil=codeworda/sqrt(2)+(codewordb*sqrt(-1))/sqrt(2);
          out_simbol =  hasil;
%         [out_simbol,code_bit,code_simbol]=mapper(codeword,'qpsk');
        
        Hk=1;%kanal sempurna
        noise= sigma*(randn(1,length(out_simbol)) + sqrt(-1)*randn(1,length(out_simbol)));%noise
        rx1 = (Hk.*out_simbol) + noise;%penambahan noise
        
        %riil
%         for lol=1:length(rx1)
%             hasilriil=(2/sigma^2)*real(rx1(lol));
%             Lci=[Lci hasilriil];
%         end
        
         hasilriil=(2/sigma^2)*real(rx1);
         Lcir=hasilriil;
%         
%         %im
%         for lil=1:length(rx1)
%             hasilim=(2/sigma^2)*imag(rx1(lil));
%             Lci=[Lci hasilim];
%         end
        
         hasilim=(2/sigma^2)*imag(rx1);
         Lcii=hasilim;
         
         [Lci]=[Lcir Lcii];
%         [Lci]=soft_demapper_QPSK(rx1,code_bit,code_simbol,sigma);
%           [Lci]=real(rx1);

         
            %PROSES ITERATIVE DECODING
%               

                 Lrji= zeros(p,n);
                 
        
%               
                    [ber,Lrji,hatb, iter] = decode_LDPC_2310(Lrji,Lci,H,iter_LDPC,information,k);
                     
                       

BER=BER+ber;
% fprintf('frame =%g, ber=%d\n', jj, ber);
fprintf('frame =%g, ber=%d, iter=%d\n ', jj, ber, iter);


end %iterframe
%     

    Hasilber=BER/(frame*k);

    fprintf('BER=%d, \n', Hasilber);
% end

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