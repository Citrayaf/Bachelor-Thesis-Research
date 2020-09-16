  function [IE_VND, IA_VND]= EXIT_LDPC_AWGN_VND(IA_ch)
IA_VND=0:0.001:1;
IA_VND(end) = 0.999999;
% IA_ch = 0.77;
% for jj=1:23 
for ii=1:length(IA_VND)
%   IE_VND(ii) =  12960/64800*(j_function(sqrt((8-1)*(inverseJfunction(IA_VND(ii)))^2+inverseJfunction(IA_ch)^2)))+...
%                 19440/64800*(j_function(sqrt((3-1)*(inverseJfunction(IA_VND(ii)))^2+inverseJfunction(IA_ch)^2)))+...
%                 32399/64800*(j_function(sqrt((2-1)*(inverseJfunction(IA_VND(ii)))^2+inverseJfunction(IA_ch)^2)))+...
%                 1/64800*(j_function(sqrt((1-1)*(inverseJfunction(IA_VND(ii)))^2+inverseJfunction(IA_ch)^2)));
% IE_VND(ii) =  36/180*(j_function(sqrt((8-1)*(inverseJfunction(IA_VND(ii)))^2+inverseJfunction(IA_ch)^2)))+...
%                 54/180*(j_function(sqrt((3-1)*(inverseJfunction(IA_VND(ii)))^2+inverseJfunction(IA_ch)^2)))+...
%                 89/180*(j_function(sqrt((2-1)*(inverseJfunction(IA_VND(ii)))^2+inverseJfunction(IA_ch)^2)))+...
%                 1/180*(j_function(sqrt((1-1)*(inverseJfunction(IA_VND(ii)))^2+inverseJfunction(IA_ch)^2)));
% rate 1/2 skale terkecil 64800
% IE_VND(ii) =  36/540*(j_function(sqrt((13-1)*(inverseJfunction(IA_VND(ii)))^2+inverseJfunction(IA_ch)^2)))+...
%                 324/540*(j_function(sqrt((3-1)*(inverseJfunction(IA_VND(ii)))^2+inverseJfunction(IA_ch)^2)))+...
%                 179/540*(j_function(sqrt((2-1)*(inverseJfunction(IA_VND(ii)))^2+inverseJfunction(IA_ch)^2)))+...
%                 1/540*(j_function(sqrt((1-1)*(inverseJfunction(IA_VND(ii)))^2+inverseJfunction(IA_ch)^2)));
%             rate 2/3 skala 1/120 6480
% IE_VND(ii) =  108/540*(j_function(sqrt((8-1)*(inverseJfunction(IA_VND(ii)))^2+inverseJfunction(IA_ch)^2)))+...
%                 162/540*(j_function(sqrt((3-1)*(inverseJfunction(IA_VND(ii)))^2+inverseJfunction(IA_ch)^2)))+...
%                 269/540*(j_function(sqrt((2-1)*(inverseJfunction(IA_VND(ii)))^2+inverseJfunction(IA_ch)^2)))+...
%                 1/540*(j_function(sqrt((1-1)*(inverseJfunction(IA_VND(ii)))^2+inverseJfunction(IA_ch)^2)));
%             rate 1/2 skala 1/120
% IE_VND(ii) =  360/3240*(j_function(sqrt((8-1)*(inverseJfunction(IA_VND(ii)))^2+inverseJfunction(IA_ch)^2)))+...
%                 1080/3240*(j_function(sqrt((3-1)*(inverseJfunction(IA_VND(ii)))^2+inverseJfunction(IA_ch)^2)))+...
%                 1839/3240*(j_function(sqrt((2-1)*(inverseJfunction(IA_VND(ii)))^2+inverseJfunction(IA_ch)^2)))+...
%                 1/3240*(j_function(sqrt((1-1)*(inverseJfunction(IA_VND(ii)))^2+inverseJfunction(IA_ch)^2)));

%16200 ORI

IE_VND(ii) =  1800/16200*(j_function(sqrt((8-1)*(inverseJfunction(IA_VND(ii)))^2+inverseJfunction(IA_ch)^2)))+...
                5400/16200*(j_function(sqrt((3-1)*(inverseJfunction(IA_VND(ii)))^2+inverseJfunction(IA_ch)^2)))+...
                8999/16200*(j_function(sqrt((2-1)*(inverseJfunction(IA_VND(ii)))^2+inverseJfunction(IA_ch)^2)))+...
                1/16200*(j_function(sqrt((1-1)*(inverseJfunction(IA_VND(ii)))^2+inverseJfunction(IA_ch)^2)));



% IE_VND(ii) =  30/270*(j_function(sqrt((8-1)*(inverseJfunction(IA_VND(ii)))^2+inverseJfunction(IA_ch)^2)))+...
%                 90/270*(j_function(sqrt((3-1)*(inverseJfunction(IA_VND(ii)))^2+inverseJfunction(IA_ch)^2)))+...
%                 149/270*(j_function(sqrt((2-1)*(inverseJfunction(IA_VND(ii)))^2+inverseJfunction(IA_ch)^2)))+...
%                 1/270*(j_function(sqrt((1-1)*(inverseJfunction(IA_VND(ii)))^2+inverseJfunction(IA_ch)^2)));
% IE_VND(ii) =  1800/16200*(j_function(sqrt((8-1)*(inverseJfunction(IA_VND(ii)))^2+inverseJfunction(IA_ch)^2)))+...
%                 5400/16200*(j_function(sqrt((3-1)*(inverseJfunction(IA_VND(ii)))^2+inverseJfunction(IA_ch)^2)))+...
%                 8999/16200*(j_function(sqrt((2-1)*(inverseJfunction(IA_VND(ii)))^2+inverseJfunction(IA_ch)^2)))+...
%                 1/16200*(j_function(sqrt((1-1)*(inverseJfunction(IA_VND(ii)))^2+inverseJfunction(IA_ch)^2)));
%               rate 4/9 PEG
IE_VND(ii) =  30/270*(j_function(sqrt((8-1)*(inverseJfunction(IA_VND(ii)))^2+inverseJfunction(IA_ch)^2)))+...
                90/270*(j_function(sqrt((3-1)*(inverseJfunction(IA_VND(ii)))^2+inverseJfunction(IA_ch)^2)))+...
                149/270*(j_function(sqrt((2-1)*(inverseJfunction(IA_VND(ii)))^2+inverseJfunction(IA_ch)^2)))+...
                1/270*(j_function(sqrt((1-1)*(inverseJfunction(IA_VND(ii)))^2+inverseJfunction(IA_ch)^2)));


end
% figure

 plot(IA_VND,IE_VND,'r:','linewidth',1)
 xlabel('I_{A,VND},I_{E,CND}');
ylabel('I_{E,VND},I_{A,CND}');
   end