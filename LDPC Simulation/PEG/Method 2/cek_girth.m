clc
clear all

load Matrix_H.mat

depth=[];
varnode=[];

[m, n]=size(H);

for dvs=1:n
    
    varnode=[varnode dvs];
    lini=[];
    sn=[];
    [bar,kol]=size(H);
    Msimpan=zeros(bar,kol);
    vsem=[];
    sn=dvs;
    vsem=[vsem sn];
    csem=[];
    vgakboleh=sn;
    cgakboleh=[];
    l=0;
    stop=0;
    looping=0;

    while true
        looping=looping+1;

        csem=[];
        vsemu=unique(vsem);
        l=l+1;
        Msimpan=zeros(bar,kol);
        for j=1:length(vsemu)
            cn=find(H(:,vsemu(j)));
            cn2=find(Msimpan(:,vsemu(j)));

            beda=setdiff(cn',cgakboleh);
            csem=[csem beda];

            Msimpan(beda,vsemu(j))=1;
        end

        csemu=unique(csem);
        if looping>=2
            for cek=1:length(csemu)
                 if sum(Msimpan(csemu(cek),:))==sum(H(csemu(cek),:)) && sum(H(csemu(cek),:))~=1
                    stop=1;
                    l=l+1;
                 end
            end
        end
        if stop == 1
            break
        end
        cgakboleh=csem;
        Msimpan=zeros(bar,kol);
        vsem=[];
        l=l+1;

        for i=1:length(csemu)
            vn=find(H(csemu(i),:));
            masuk2=setdiff(vn,vgakboleh);
            vsem=[vsem masuk2];
            Msimpan(csemu(i),masuk2)=1;
        end
        
        vgakboleh = vsem;
        vsemu = unique(vsem);
        for cek= 1 : length(vsemu)
               if sum(Msimpan(:, vsemu(cek)))==sum(H(:, vsemu(cek))) && sum(H(:,vsemu(cek)))~=1 %This for LDPC with degree 1
                   stop=1;
                   break
               end
        end

        if stop == 1
           break
        end

    end
    depth=[depth l*2];
end

plot (varnode,depth);
batas=[0 4 6 8 12 16];
yticks(batas);  
axis([1 n 0 20]);
figure(1);
Figure1 = figure(1);

% Create ylabel

FigW = 6;
FigH = 3.25;
set(Figure1,'defaulttextinterpreter','latex',...
    'PaperUnits','inches','Papersize',[FigW,FigH],...
    'Paperposition',[0,0,FigW,FigH],'Units','Inches',...
    'Position',[0,0,FigW,FigH])
set(gca,...
    'FontSize',11,...
    'FontName','Arial');
print ('-dpdf','-r500','hasil_girth3.pdf');

ylabel({'Girth'});

% Create xlabel
xlabel({'Variable node (n)'});
