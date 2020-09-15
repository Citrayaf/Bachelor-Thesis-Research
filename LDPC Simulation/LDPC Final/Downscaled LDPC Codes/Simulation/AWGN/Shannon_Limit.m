clear all
clc

BER=0.5:-0.000001:1e-6;
eta=(1/5);
 for t=1:length(BER)
 H_BER(t)=BER(t)*log2(BER(t)^-1)+(1-BER(t))*log2((1-BER(t))^-1);
 EbNo(t)=((2^((1-H_BER(t))*eta)-1)*(1-H_BER(t)))/eta;
SNR(t)=eta*EbNo(t);
 end
 
 semilogy(10*log10(SNR),BER,'-r');
  axis([-10 7 0.99*10^-5 10^0])