warning off;
clear all;
clc;

tic

%Inisialisasi Path
% input = importdata('untuk_ber_bdg.xlsx');
% input=[1	0.162349	0.05334     0.017159	0.005685	0.001905	0.000429	0.000174];%situbondo
input=[1	0.17735768	0.058438626	0.018028102	0.006311026	0.002133536	0.000500726	0.000208978];%Bandung
% input=[1	1	0	0	0	0	0	0];%Bandung


path_len = length(input);  %jumlah path
for mm=1:path_len
    h(mm) = sqrt(input(mm));%tanya ka reni
end

%Inisialisasi Parameter Input
m = 4;  %modulasi yang digunakan
M = log2(m);
% R = 4/9;
FFTSize = 256;
Jumlahsim=256*M;
N = 270;  %jumlah simbol

%LDPC
iter_LDPC =50;
load Hr=1-2.mat
load Gr=1-2.mat
[p n] = size(H);
k = n-p;

KR = floor(k);
% cp_len = ceil((4.69/66.67)*FFTSize);  %numerology yang digunakan
cp_len=8;
Check = (Jumlahsim)-N;    % Check value of N to fill up FFT size
if Check == 0
    ps = 0;
else
    ps = Check;
end

%Konfigurasi OFDM
SNR = 5;
snr = 10.^(SNR/10);
frame = 5;
F = dftmtx(FFTSize)/sqrt(FFTSize);  %FFT
Fh = F';  %IFFT
ptop = FFTSize+cp_len*2;
pdat = cp_len+FFTSize;

%Iterasi Sistem
% for Case=1:length(SNR)
    fprintf('SNR: %d\n', SNR);
    ber = 0;
    fer = 0;
    sigma = sqrt(1/(2*snr));
% if SNR(Case) <= 5
%     frame=300;
% else
%     if SNR(Case) > 5 && SNR(Case) <= 10
%         frame=350;
%     else
%         if SNR(Case) > 10 && SNR(Case) <= 15
%             frame=2000;
%         else
%             if SNR(Case) > 15 && SNR(Case) <= 20
%                 frame=3000;
%                 else
%                     if SNR(Case) > 20 && SNR(Case) <= 25
%                         frame=5000;
%                     else
%                         if SNR(Case) > 25 && SNR(Case) <= 30
%                             frame=7500;
%                         end
%                     end
%              end
%         end
%      end
% end

        h_T = zeros(ptop-1,pdat);


            
    for j=1:frame
        berper=0;
        %Generate Bit
        u = randi([0,1], 1, KR);
        
        kumpul=[];

        %LDPC Encoder
        c = mod(u*G,2); 

        
        %Repetition Encoder
%         [c] = repetitionencoder(u, repeat);
%         cd = [c c(1:Check)];
%         s=zeros(1,(Check));
%         for i=1:(Check)
%             s(:,1)=[0];
%         end
%         cd=[c s];
        
        for sx=1:32
        if sx==1
            pot{1,sx}=c(1,1:512);
        else
            sd=sx*512;
            sa=((sx-1)*512)+1;
            if sx==31
                sa=15361;
                sd=15872;
            end
            if sx==32
                sa=15873;
                sd=16200;
            end
           pot{1,sx}=c(1, sa:sd); 
        end
        end
        
        Check=184;
        s=zeros(1,(Check));
        for i=1:(Check)
            s(:,1)=[0];
        end
        cd=[pot{1,32} s];
        pot{1,32}=cd;
        
        for jj=1:path_len
            Hk(jj) = h(jj)*(randn(1,1)+sqrt(-1)*randn(1,1))/sqrt(2);
        end
        
        %Matriks Toeplitz
        for iii=1:pdat
            for jjj=1:path_len
                h_T(jjj+iii-1,iii) = Hk(jjj);
            end
        end
        
        
        for jx=1:32
        %Bit Interleaver
%         pi = randperm(length(cd));
%         ci = intrlv(cd, pi);
        
        %Mapper BPSK
%         [out_simbol, code_bit, code_simbol] = mapper(ci,'bpsk');
%         [out_simbol, code_bit, code_simbol] = mapper(pot{1,jx},'qpsk');
          [out_simbol]=qpskman(pot{1,jx});

%         s=zeros((Check),1);
%         for i=1:(Check)
%             s(:,1)=[-1];
%         end 
%         tx=[out_simbol;s];
%         cd = [c c(1:Check)];

        %Transmitter
        tx = out_simbol;
        
        %Inisialisasi OFDM
        %IFFT
        out_ifft = ifft(tx.')*sqrt(length(tx));
        
        %Penambahan CP
        out_ifft_cp = [out_ifft(end-cp_len+1:end) out_ifft];
        
        %Kanal Multipath Fading
        
        
       
        
        %Penambahan Noise
        y_cp = h_T*out_ifft_cp.';
        noise = sigma*(randn(length(y_cp),1)+sqrt(-1)*randn(length(y_cp),1));
        y_cpn = y_cp+noise;  %y=hx+n
        
        %Penghapusan CP
        y = y_cpn(cp_len+1:end-cp_len+1);
        
        %FFT
        out_fft = fft(y)/sqrt(length(y));
        
        %Channel Equalizer
        Heq = circulant([Hk zeros(1,FFTSize-path_len)]);
        psi = F*Heq*Fh;
        psi_val = diag(psi);
        
        
        
        %MMSE - Demapper
        yeq = out_fft.*conj(psi_val);
        
%         yeq=out_fft.*conj(psi_val)./(psi_val.*conj(psi_val)+sigma^2);
        
        [Lci]=qpskllrman(yeq,sigma);
        LCi=Lci;
        if jx==32
            LCi  = Lci(1:328);%pelepasan dummy
        end %pelepasan dummy

        %SOFT Demapper
%         [LCi] = soft_demapper_QPSK (yeq,code_bit,code_simbol,sigma);
        
        %LDPC Decoder
%         La_vnd_LDPC= zeros(1,n);

        kumpul=[kumpul LCi.'];


        end
        Lrji= zeros(p,n);
        
                     %LDPC codes iterative decoding    
        [berper,Lrji,hatb, iter] = decode_LDPC_2310(Lrji,kumpul,H,iter_LDPC,u,KR);
                       
        %Repetition Decoder
%         [bit_de] = repetitiondecoder(dci2, repeat);
        
        %BER & FER Calculations
%         compare_bit = sum(bit_de~=u);
       
        ber = ber+berper;
        if berper~=0
            fer = fer+1;
        end
            fprintf('frame =%g, ber=%d, iter=%d \n ', j, berper, iter);

    end
    fprintf('BER : %d',ber);
    BER = ber/frame/KR;
    FER = fer/frame;
        fprintf('BER : %d',BER);

% end

%BER Figure
% fprintf('BER: %d \n', BER);
% semilogy(SNR, BER, '*-', 'linewidth', 1);
% xlabel('SNR (dB)');
% ylabel('BER');
% 
% FER Figure
% fprintf('FER: %d\n', FER);
% semilogy(SNR, FER, 'o-', 'linewidth', 1);
% xlabel('SNR (dB)');
% ylabel('FER');
% 
% Setting Figure
% figure(1);
% Figure1 = figure(1);
% FigW = 6;
% FigH = 5.6;
% set(Figure1,'defaulttextinterpreter','latex',...
%     'PaperUnits','inches','Papersize',[FigW,FigH],...
%     'Paperposition',[0,0,FigW,FigH],'Units','Inches',...
%     'Position',[0,0,FigW,FigH])
% set(gca,...
%     'FontSize',10,...
%     'FontName','Arial');
% 
% toc