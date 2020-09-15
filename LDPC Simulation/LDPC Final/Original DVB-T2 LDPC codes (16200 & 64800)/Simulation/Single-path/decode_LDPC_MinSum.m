      %mencari nilai per baris(representasi per check nodes)
% Decode Min Sum
function [berr,Le_CND, b,iter] = decode_LDPC_MinSum(Lrji, Lch, H, iteration,info,juminfo)
      
    rows = size(H, 1);
    cols = size(H, 2);
        
%     Le_VND= zeros(rows,cols);
    La_VND= zeros(rows,cols);
    Le_CND= Lrji;
    La_CND= zeros(rows,cols);
    
    %masuk LLR chanel
    %iterasi ke-0
    for k=1:cols
        el1=find(H(:,k));
        La_VND(el1,k)=Lch(k);
    end
    
    Le_VND=La_VND;
    
    for iter = 1 : iteration
        
        %check node
        for m=1:rows
            el2=find(H(m,:));
            for ec=1:length(el2)
                el2_baru=setdiff(el2,el2(ec));                
                for ee=1:length(el2_baru)
                    if ee==1
                        operasi_CND=Le_VND(m,el2_baru(ee));
                    else
                        operasi_CND=sign(operasi_CND)*sign(Le_VND(m,el2_baru(ee)))*min(abs([operasi_CND Le_VND(m,el2_baru(ee))]));
                    end 
                end
                La_CND(m,el2(ec))=operasi_CND;       
            end
        end
        
        Le_CND=La_CND;
        
        
        %variable node
        for k=1:cols
            eel1=find(H(:,k));
            for ev=1:length(eel1)
                La_VND(eel1(ev),k)=Lch(k)+sum(Le_CND(eel1,k))-Le_CND(eel1(ev),k);
            end
        end
        
        Le_VND=La_VND;
        
        for in=1:juminfo
            ub(in)=sum(Le_CND(:,in))+Lch(in);
        end
        
        for j=1:juminfo
            if ub(j)>0
                b(j)=0;
            else
                b(j)=1;
            end
        end
        
        berr = sum(abs(b(1:juminfo)-info));

        if berr==0 
           break
        end
        
    end
    
    