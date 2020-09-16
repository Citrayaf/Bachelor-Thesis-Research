  function [IE_CND_Ext, IE_VND, IA_CND]= EXIT_CND_DVB(IA_ch)
IA_CND=0:0.001:1;
IA_CND(end) = 0.999999;

for ii=1:length(IA_CND)
%   IE_CND_LDPC(ii)=1/32400*(1-j_function(sqrt((6-1)*(inverseJfunction(1-IA_CND(ii)))^2)))+...
%                   32399/32400*(1-j_function(sqrt((7-1)*(inverseJfunction(1-IA_CND(ii)))^2)));
%                IE_CND_LDPC(ii)=1/1080*(1-j_function(sqrt((9-1)*(inverseJfunction(1-IA_CND(ii)))^2)))+...
%                    1079/1080*(1-j_function(sqrt((10-1)*(inverseJfunction(1-IA_CND(ii)))^2)));
%                skala 1/60
%                IE_CND_LDPC(ii)=7/90*(1-j_function(sqrt((9-1)*(inverseJfunction(1-IA_CND(ii)))^2)))+...
%                    83/90*(1-j_function(sqrt((10-1)*(inverseJfunction(1-IA_CND(ii)))^2)));

%                    720/1800*(1-j_function(sqrt((6-1)*(inverseJfunction(1-IA_CND(ii)))^2)))+...
%                    144/1800*(1-j_function(sqrt((7-1)*(inverseJfunction(1-IA_CND(ii)))^2)));
     


%Matriks 16200
  IE_CND_LDPC(ii)=1/5400*(1-j_function(sqrt((9-1)*(inverseJfunction(1-IA_CND(ii)))^2)))+...
                  5399/5400*(1-j_function(sqrt((10-1)*(inverseJfunction(1-IA_CND(ii)))^2)));




%                Rate 2/3 PEG
               IE_CND_LDPC(ii)=37/90*(1-j_function(sqrt((10-1)*(inverseJfunction(1-IA_CND(ii)))^2)))+...
                   53/90*(1-j_function(sqrt((9-1)*(inverseJfunction(1-IA_CND(ii)))^2)));

%                   rate 1/2 scale terkecil
%                 IE_CND_LDPC(ii)=1/180*(1-j_function(sqrt((9-1)*(inverseJfunction(1-IA_CND(ii)))^2)))+...
%                   179/180*(1-j_function(sqrt((10-1)*(inverseJfunction(1-IA_CND(ii)))^2)));
%               
%               rate 2/3 skala 1/120
% IE_CND_LDPC(ii)=1/270*(1-j_function(sqrt((9-1)*(inverseJfunction(1-IA_CND(ii)))^2)))+...
%                   269/270*(1-j_function(sqrt((10-1)*(inverseJfunction(1-IA_CND(ii)))^2)));
%               rate 1/2 skala 1/120
end
 plot(IE_CND_LDPC,IA_CND,'b-','linewidth',1)
 