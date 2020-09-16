  function [IE_CND_Ext, IE_VND, IA_CND]= EXIT_CND_DVB(IA_ch)
IA_CND=0:0.001:1;
IA_CND(end) = 0.999999;

for ii=1:length(IA_CND)
%   IE_CND_LDPC(ii)=1/32400*(1-j_function(sqrt((6-1)*(inverseJfunction(1-IA_CND(ii)))^2)))+...
%                   32399/32400*(1-j_function(sqrt((7-1)*(inverseJfunction(1-IA_CND(ii)))^2)));
%                IE_CND_LDPC(ii)=1/1296*(1-j_function(sqrt((8-1)*(inverseJfunction(1-IA_CND(ii)))^2)))+...
%                    1295/1296*(1-j_function(sqrt((9-1)*(inverseJfunction(1-IA_CND(ii)))^2)));
%                    720/1800*(1-j_function(sqrt((6-1)*(inverseJfunction(1-IA_CND(ii)))^2)))+...
%                    144/1800*(1-j_function(sqrt((7-1)*(inverseJfunction(1-IA_CND(ii)))^2)));
% skala 1/60
% IE_CND_LDPC(ii)=1/108*(1-j_function(sqrt((8-1)*(inverseJfunction(1-IA_CND(ii)))^2)))+...
%                    107/108*(1-j_function(sqrt((9-1)*(inverseJfunction(1-IA_CND(ii)))^2)));
%                   
%                   rate 1/2 scale terkecil
% skala 1/120
% IE_CND_LDPC(ii)=1/216*(1-j_function(sqrt((10-1)*(inverseJfunction(1-IA_CND(ii)))^2)))+...
%                    215/216*(1-j_function(sqrt((11-1)*(inverseJfunction(1-IA_CND(ii)))^2)));
                  
%                 IE_CND_LDPC(ii)=1/180*(1-j_function(sqrt((9-1)*(inverseJfunction(1-IA_CND(ii)))^2)))+...
%                   179/180*(1-j_function(sqrt((10-1)*(inverseJfunction(1-IA_CND(ii)))^2)));
%               rate 2/3 skala 1/120
% IE_CND_LDPC(ii)=1/270*(1-j_function(sqrt((9-1)*(inverseJfunction(1-IA_CND(ii)))^2)))+...
%                   269/270*(1-j_function(sqrt((10-1)*(inverseJfunction(1-IA_CND(ii)))^2)));
%               rate 1/2 skala 1/120

%matriks 16200
  IE_CND_LDPC(ii)=1/6480*(1-j_function(sqrt((8-1)*(inverseJfunction(1-IA_CND(ii)))^2)))+...
                  6479/6480*(1-j_function(sqrt((9-1)*(inverseJfunction(1-IA_CND(ii)))^2)));



% Rate 3/5 PEG
IE_CND_LDPC(ii)=59/108*(1-j_function(sqrt((8-1)*(inverseJfunction(1-IA_CND(ii)))^2)))+...
                   49/108*(1-j_function(sqrt((9-1)*(inverseJfunction(1-IA_CND(ii)))^2)));

end
 plot(IE_CND_LDPC,IA_CND,'b-','linewidth',1)
 