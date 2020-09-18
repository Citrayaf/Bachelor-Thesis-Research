clc
clear all
n=120;
m=150;
indexmin=0;
dv1=[];
dv2=[];
dv3=[];
dv4=[];
for di=1:30
    div1=8;
    dv1=[dv1 div1];
end
for di=1:90
    div2=3;
    dv2=[dv2 div2];
end
for di=1:149
    div3=2;
    dv3=[dv3 div3];
end
for di=1:1
    div4=1;
    dv4=[dv4 div4];
end
dv=[dv3 dv4 dv1 dv2];

load Hs1-2(4-9){1-60}.mat
[kk, n] = size(H);
inz = n-kk;
Hb=zeros(m, (n-kk));

H2=H(:,(inz+1):270);
H=[H2 Hb];


for j=(kk+1):270    
    for k=1:dv(j)
        if k==1
            min=1000;
            for i=1:m
                dci=sum(H,2);
                if (dci(i)<min)
                    min=dci(i);
                    indexmin=i;
                end
            end
            H(indexmin,j)=1;
        else
            count1=1;
            barisjadi=1;
            countsatu=0;
            jumnil1=zeros(1,m);
            while true
                if H(barisjadi,j)==0 && count1<=dv(j)
                    kolom1=1;
                    bisa=1;
                    baris1=1;
                    loopstop=0;
                    bataskolom=j-1;
                    batasbaris=barisjadi;
                    while kolom1<=bataskolom
                        if H(barisjadi,bataskolom)==1
                            countsatu=1;
                            for baris2=1:m
                                if H(baris2,bataskolom)==1 && baris2~=barisjadi
                                    countsatu=2;
                                    if H(baris2,j)==1
                                        countsatu=3;
                                        loopstop=1;
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
                    jumnil1(1,barisjadi)=countsatu;

                    
                end
                barisjadi=barisjadi+1;
                if barisjadi>m
                    break;
                end
            end
            
            count1=k-1;
            hentiacak=[];
            for br=1:m
                bn=sum(H,2);
                bsr=sort(bn);
                jadi2=find(bsr(br,1)==bn);
                cekrandom=find(H(jadi2,j));
                ceksatukolom=jadi2(cekrandom);
                jadi = setdiff(jadi2, ceksatukolom);
                
                while true
                    if count1==k
                        break
                    end
                    kili=randi(length(jadi),1);
                    if count1<k
                        %cari min lagi kyak sebelumnya yg buat baris
                        if jumnil1(1,jadi(kili))<3
                            if H(jadi(kili),j)~=1
                                H(jadi(kili),j)=1;
                                count1=count1+1;
                            end
                        end
                    end
                    
                    hentiacak=[hentiacak jadi(kili)];
                    
                    if isempty(setdiff(jadi,hentiacak))
                        break
                    end    
                end
            end 
        end
    end
end

save('Matrix_H_besar','H');

