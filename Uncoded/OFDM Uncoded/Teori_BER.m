%Revisi Tanggal 5 Maret 2019 di AdWiTech
clc;
clear all;

snr =0:1:30; %dB
gamma = 10.^(snr/10);

R = 1; %without channel coding
% M = 64;
% k = log2(M);

for ii=1:length(snr)
    fprintf('SNR: %d\n', snr(ii));
%     BER_bpsk_awgn(ii)=0.5*erfc(sqrt(gamma(ii)));
%      BER_qpsk_awgn(ii)=0.5*erfc(sqrt(gamma(ii)/2));
%     BER_16qam_awgn(ii)=3/8*erfc(sqrt(gamma(ii)/10))-9/64*erfc(sqrt(gamma(ii)/10))^2;
%     BER_64qam_awgn(ii)=7/24*erfc(sqrt(gamma(ii)/42))-49/384*erfc(sqrt(gamma(ii)/42))^2;
%     BER_bpsk_fading(ii)=0.5*(1-(1/(sqrt(1+(1/(gamma(ii)))))));
     BER_qpsk_fading(ii)=0.5*(1-(1/(sqrt(1+(2/(gamma(ii)))))));
   %  BER_16qam_fading(ii)=3/8*(1-(1/(sqrt(1+(10/gamma(ii))))));
%     BER_64qam_fading(ii)=7/24*(1-(1/(sqrt(1+(42/gamma(ii))))));
%     BER_64qam_fading(ii)=7/24 * ( 1 - sqrt(1/7*gamma(ii)/k./(1+1/7*gamma(ii)/k)) );
end

% semilogy(snr,BER_bpsk_awgn,'-r','linewidth',1);
% hold on;
% semilogy(snr,BER_bpsk_fading,'-r*','linewidth',1)
%  semilogy(snr,BER_qpsk_awgn,'-r*','linewidth',1)
% hold on;
 semilogy(snr,BER_qpsk_fading,'-rs','linewidth',1)
% semilogy(SNR,BER_16qam_awgn,'--r*','linewidth',1)
hold on;
% semilogy(SNR,BER_16qam_fading,'--ro','linewidth',1)
% semilogy(SNR,BER_64qam_awgn,'--m*','linewidth',1)
% hold on;
%  semilogy(SNR,BER_64qam_fading,'--mo','linewidth',1)
axis([0 30 10^-4 10^0])
% grid on;