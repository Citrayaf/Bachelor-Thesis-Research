%tanner_graph

load Matrix_H.mat

sn=3;
node={};
nodeasli={};
l=1;
node{l}=0;
nodeasli{l}=sn;
cnode=[];
vnode=[];
vnode=[vnode sn];
cn=find(H(:,sn));
loop=length(cn);
l=2;
node{l}=cn';
clini=[];
clini=cn';
cnode=[cnode clini];
panjang1=length(node{l});
matsem1=zeros(1,panjang1);
matsem1=matsem1+(l-1);
node{l}=matsem1;
nodeasli{l}=clini;

vkum=[];
ckum=[];
mnod=[];
nnod=[];
vlini=[];
b=2;

 while true

    vlini=[];
    i=1;
    j=1;
    mnod=[];
    for vl=1:loop
        
        vn=find(H(clini(vl),:));
        vn2=setdiff(vn,vnode);

        if isempty(vn2)==1
            b=b+1;
        else
            lcek=length(vnode);
            lvn=length(vn2);
            
            vkum=vn2;
            vlini=[vlini vn2];
            panjang2=length(vn2);
            matsem2=zeros(1,panjang2);
            matsem2=matsem2+b;
            mnod=[mnod matsem2];
            vnode=[vnode vkum];
                    
            b=b+1;
        end
        if vl==loop
            l=l+1;
            loopc=length(vlini);
            node{l}=mnod;
            nodeasli{l}=vlini;
            vkum=[];
        end
        
    end
            
    loop=0;
    clini=[];
    nnod=[];
    for cl=1:loopc
        cn=find(H(:,vlini(cl)));
        cn2=setdiff(cn,cnode);  
        if isempty(cn2)==1
            b=b+1;
        else
            lccek=length(cnode);
            lcn=length(cn2);
        
            if isempty(cn)==1
                b=b+1;
            end
            
            ckum=cn2';
            clini=[clini cn2'];
            panjangc2=length(cn2);
            matsemc2=zeros(1,panjangc2);
            matsemc2=matsemc2+b;
            nnod=[nnod matsemc2];
            cnode=[cnode ckum];
                    
            b=b+1;
        end
        
        if cl==loopc

            l=l+1;
            loop=length(clini);
            node{l}=nnod;
            nodeasli{l}=clini;

            ckum=[];
        end
        
    end
    
    if length(vnode)==n && length(cnode)==m
        break;
    end
    
 end
 matriks_plot_jadi=[];
 for kum=1:l-1
     matriks_plot_jadi=[matriks_plot_jadi node{kum}];
 end

treeplot(matriks_plot_jadi);