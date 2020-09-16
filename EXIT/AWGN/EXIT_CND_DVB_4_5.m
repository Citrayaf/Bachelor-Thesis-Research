  function [IE_CND_Ext, IE_VND, IA_CND]= EXIT_CND_DVB(IA_ch)
IA_CND=0:0.001:1;
IA_CND(end) = 0.999999;

for ii=1:length(IA_CND)
%   IE_CND_LDPC(ii)=1/32400*(1-j_function(sqrt((6-1)*(inverseJfunction(1-IA_CND(ii)))^2)))+...
%                   32399/32400*(1-j_function(sqrt((7-1)*(inverseJfunction(1-IA_CND(ii)))^2)));
%                IE_CND_LDPC(ii)=73/720*(1-j_function(sqrt((11-1)*(inverseJfunction(1-IA_CND(ii)))^2)))+...
%                    215/720*(1-j_function(sqrt((12-1)*(inverseJfunction(1-IA_CND(ii)))^2)))+...
%                    432/720*(1-j_function(sqrt((13-1)*(inverseJfunction(1-IA_CND(ii)))^2)));
%                skala 1/60
%                IE_CND_LDPC(ii)=7/60*(1-j_function(sqrt((11-1)*(inverseJfunction(1-IA_CND(ii)))^2)))+...
%                    29/60*(1-j_function(sqrt((12-1)*(inverseJfunction(1-IA_CND(ii)))^2)))+...
%                    24/60*(1-j_function(sqrt((13-1)*(inverseJfunction(1-IA_CND(ii)))^2)));

               IE_CND_LDPC(ii)=361/3600*(1-j_function(sqrt((11-1)*(inverseJfunction(1-IA_CND(ii)))^2)))+...
                   1079/3600*(1-j_function(sqrt((12-1)*(inverseJfunction(1-IA_CND(ii)))^2)))+...
                   2160/3600*(1-j_function(sqrt((13-1)*(inverseJfunction(1-IA_CND(ii)))^2)));



% Rate 4/5 PEG
               IE_CND_LDPC(ii)= 31/60*(1-j_function(sqrt((12-1)*(inverseJfunction(1-IA_CND(ii)))^2)))+...
                   29/60*(1-j_function(sqrt((13-1)*(inverseJfunction(1-IA_CND(ii)))^2)));


%                skala 1/120 64800
%     IE_CND_LDPC(ii)=1/108*(1-j_function(sqrt((17-1)*(inverseJfunction(1-IA_CND(ii)))^2)))+...
%                    107/108*(1-j_function(sqrt((18-1)*(inverseJfunction(1-IA_CND(ii)))^2)));

%                    720/1800*(1-j_function(sqrt((6-1)*(inverseJfunction(1-IA_CND(ii)))^2)))+...
%                    144/1800*(1-j_function(sqrt((7-1)*(inverseJfunction(1-IA_CND(ii)))^2)));
                  
%                   rate 1/2 scale terkecil

%                 IE_CND_LDPC(ii)=1/180*(1-j_function(sqrt((9-1)*(inverseJfunction(1-IA_CND(ii)))^2)))+...
%                   179/180*(1-j_function(sqrt((10-1)*(inverseJfunction(1-IA_CND(ii)))^2)));
%               rate 2/3 skala 1/120
% IE_CND_LDPC(ii)=1/270*(1-j_function(sqrt((9-1)*(inverseJfunction(1-IA_CND(ii)))^2)))+...
%                   269/270*(1-j_function(sqrt((10-1)*(inverseJfunction(1-IA_CND(ii)))^2)));
%               rate 1/2 skala 1/120
end
 plot(IE_CND_LDPC,IA_CND,'b-','linewidth',1)
 