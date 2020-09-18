clc;
clear all;

m = 2;
M = log2(m);

SNR = 0:2:50;
snr = 10.^(SNR/10);
% snr = ebn*M*R;

jumlah_bit = 512;
jumlah_simbol = jumlah_bit/M;
frame = 2000;

for ii=1:length(SNR)
    fprintf('SNR: %d\n', SNR(ii));
    ber = 0;
    fer = 0;
    sigma = sqrt(1/(2*snr(ii)));
    
    for j=1:frame
        %Generate bit
        u = randi([0,1], 1, jumlah_bit);
        
        %Mapper
%         [out_simbol, code_bit, code_simbol] = mapper(u, 'bpsk');
        out_simbol = 1-2*u;

        %Transmitter
        tx = out_simbol;
         
        %Kanal fading
        h=(randn(1,1)+sqrt(-1)*randn(1,1))/sqrt(2);
        
        %penambahan noise
        y1 = h * tx;
        noise = sigma*(randn(1,jumlah_simbol)+sqrt(-1)*randn(1,jumlah_simbol));
        y2 = y1 + noise;
        
        %Zero Forcing Equalization
        y3 = y2/h;

        %MMSE Equalization
%         w = conj(h)/(h*conj(h)+(1/snr(ii)));
%         y3 = y2*w;
       
        %Soft Demapper
%         [Lci] = soft_demapper_BPSK(y2, code_bit, code_simbol, sigma);
%         Lci = (2/sigma^2)*real(y2);

        for k=1:length(y3)
            if y3(k) >= 0
                bit_demodulation(k) = 0;
            else
                bit_demodulation(k) = 1;
            end
        end
        
        %BER & FER Calculations
        compare_bit = sum(bit_demodulation~=u);
        ber = ber + compare_bit;
        if compare_bit~=0
            fer = fer + 1;
        end
        
    end
    
    BER(ii) = ber/(frame*jumlah_bit);
    FER(ii) = fer/frame;
end

%BER Figure
fprintf('BER : %d\n', BER);
semilogy(SNR, BER, '*-k', 'linewidth', 1);
xlabel('SNR (dB)');
ylabel('BER');

%Setting Figure
figure(1);
Figure1 = figure(1);
FigW = 6;
FigH = 5.6;
set(Figure1,'defaulttextinterpreter','latex',...
    'PaperUnits','inches','Papersize',[FigW,FigH],...
    'Paperposition',[0,0,FigW,FigH],'Units','Inches',...
    'Position',[0,0,FigW,FigH])
set(gca,...
    'FontSize',10,...
    'FontName','Arial');
