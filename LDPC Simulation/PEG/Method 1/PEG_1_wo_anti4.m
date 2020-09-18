clc
clear all
n = input('Enter the number of columns: ');
m = input('Enter the number of rows: ');
indexmin=0;

Dv = [];
if n > 20
   uni_dv = input('How many different dv: ');
   for iii=1:uni_dv
       fprintf('%i\n', iii);
       dv = input('dv: ');
       ss = input('from columns: ');
       ff = input('until columns: ');
       for loopd = ss : ff
           Dv(loopd) = dv;
       end
   end
else 
    for kkk = 1 : n
        fprintf('%i\n', kkk);        
        Dv(kkk) = input('Enter the dv: ');
    end
end

H=zeros(m,n);
dv = Dv;

for j=1:n    
    for k=1:dv(j)        
        if k==1
            min=1000;
            for i= 1 : m
                dci = sum(H,2);
                if ( dci(i) < min )
                    min = dci(i);
                    indexmin = i;
                end
            end
            H(indexmin, j) = 1;
        else
            count1=1;
            barisjadi=1;
            countsatu=0;
            jumnil1 = zeros(1,m);
            while true
                if H(barisjadi,j) == 0 && count1 <= dv(j)
                    kolom1=1;
                    loopstop=0;
                    bataskolom=j-1;
                    while kolom1 <= bataskolom
                        if H(barisjadi, bataskolom) == 1
                            countsatu = 1;
                            for baris2 = 1:m
                                if H( baris2, bataskolom ) == 1 && baris2 ~= barisjadi
                                    countsatu=2;
                                    if H( baris2,j ) == 1
                                        countsatu = 3;
                                        loopstop = 1;
                                    end
                                end
                                if loopstop==1
                                    break;
                                end
                            end
                        end
                        if loopstop==1
                            break;
                        end
                        bataskolom=bataskolom-1;
                    end
                    jumnil1( 1,barisjadi )=countsatu;
                end
                barisjadi=barisjadi+1;
                if barisjadi>m
                    break;
                end 
            end
            countz=k-1;
            hentiacak=[];
            for br=1:m
                bn=sum(H,2);
                bsr=sort(bn);
                jadi2=find(bsr(br,1)==bn);
                cekrandom=find(H(jadi2,j));
                ceksatukolom=jadi2(cekrandom);
                jadi = setdiff(jadi2, ceksatukolom);
                while true
                    if countz == k
                        break
                    end
                    kili=randi(length(jadi),1);
                    if countz < k
%                         if jumnil1(1,jadi(kili)) < 3
                        if H(jadi(kili),j) ~= 1
                            H(jadi(kili),j)=1;
                            countz = countz+1;
                        end
%                         end
                    end                    
                    hentiacak=[hentiacak jadi(kili)];
                    if isempty(setdiff(jadi, hentiacak))
                        break
                    end
                end
            end
        end
    end
end

