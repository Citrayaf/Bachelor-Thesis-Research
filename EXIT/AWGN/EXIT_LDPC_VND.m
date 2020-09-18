function [IE_VND, IA_VND]= EXIT_LDPC_AWGN_VND(IA_ch, m_H)
IA_VND=0:0.001:1;
IA_VND(end) = 0.999999;
dvi = sum(m_H,1);
[p n] = size(m_H);

% IA_ch = 0.77;
% for jj=1:23 
for ii=1:length(IA_VND)
    sum_dv = 0;
    un_dvi = unique(dvi);
    IE_VND(ii) = 0;
        for ij=1:length(un_dvi)
            ex_n = length(find(dvi==un_dvi(ij)));
            IE_VND(ii) = IE_VND(ii) + (ex_n/n)*(j_function(sqrt((un_dvi(ij)-1)*(inverseJfunction(IA_VND(ii)))^2+inverseJfunction(IA_ch)^2)));
            sum_dv = sum_dv + ex_n;
        end
            
end
% figure

plot(IA_VND,IE_VND,'r:','linewidth',1)
xlabel('I_{A,VND},I_{E,CND}');
ylabel('I_{E,VND},I_{A,CND}');
end