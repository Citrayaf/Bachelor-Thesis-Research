  function [IE_CND_LDPC, IA_CND]= EXIT_CND_DVB(IA_ch, m_H)
IA_CND=0:0.001:1;
IA_CND(end) = 0.999999;
dci = sum(m_H,2)';
[p n] = size(m_H);

for ii=1:length(IA_CND)
    
    sum_dc = 0;
    un_dci = unique(dci);
    IE_CND_LDPC(ii) = 0;
        for ij=1:length(un_dci)
            ex_n = length(find(dci==un_dci(ij)));
            IE_CND_LDPC(ii) = IE_CND_LDPC(ii) + (ex_n/p)*(1-j_function(sqrt((un_dci(ij)-1)*(inverseJfunction(1-IA_CND(ii)))^2)));
            sum_dc = sum_dc + ex_n;
        end


end
 plot(IE_CND_LDPC,IA_CND,'b-','linewidth',1)
 