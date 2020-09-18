clc
clear all

depth=[];
varnode=[];
%tanner
% H=[1 1 0 0 0 1 0 1 ; 0 1 1 0 0 1 1 0 ; 0 0 1 1 0 0 0 0 ; 0 0 0 1 1 0 0 1 ; 1 0 0 0 1 0 1 0 ];
% load Hs1-2(4-9){1-60}.mat
% load jadiPEG_4-9.mat
% load acak1_2.mat
% load cek.mat
[m,n]=size(H);

% H=[1 0 1 0 0 1 0 1; 1 0 0 1 0 0 1 0; 0 1 0 1 0 1 0 0; 0 1 0 0 1 0 1 1; 0 0 1 0 1 0 0 0];
for dvs=1:n
% dvs=149;
varnode=[varnode dvs];
lini=[];
sn=[];
[bar,kol]=size(H);
Msimpan=zeros(bar,kol);
vsem=[];
sn=dvs;
% lini=[lini sn];
vsem=[vsem sn];
csem=[];
vgakboleh=sn;
cgakboleh=[];
l=0;
stop=0;
looping=0;
% jalur=[];
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
%        if isempty(beda) == 1
%            if looping>1
%             stop=1;
%             break
%            end
%        end
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
%            vnsimp=find(Msimpan(csemu(i),:));
%            masuk=setdiff(vn,sn);
           masuk2=setdiff(vn,vgakboleh);
           vsem=[vsem masuk2];
           Msimpan(csemu(i),masuk2)=1;
           
%            sn=[sn masuk];
     end
     vgakboleh=vsem;
     vsemu=unique(vsem);
     for cek=1:length(vsemu)
            if sum(Msimpan(:,vsemu(cek)))==sum(H(:,vsemu(cek))) && sum(H(:,vsemu(cek)))~=1
%                 if vsemu(cek)~=150
                    stop=1;
                    break
%                 end
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
% toc
%  matriks_plot_jadi=[];
%  for kum=1:l-1
%      matriks_plot_jadi=[matriks_plot_jadi node{kum}];
%  end
% 
% %   x=[0 1 1 2 2 3 3 4 5 5 6 7 8 9 10 15]   
% treeplot(matriks_plot_jadi);
    



% end

% while true
%     for i=1:loop
%         vn=find(H(cn(i),:));
%         if vnode==vn
%             loopsel=1;
%             break;
%         end
%         if i==loop
%             vnode=[vnode vn];
%             loop2=length(vn);
%         end
%     end
%         for j=1:loop2
%             chn(j)=find(:,H(vn(i)));
%             if cnode==cn
%                 loopsel=1;
%                 break;
%             end
%             if j==loop2
%                 cnode=[cnode chn];
%                 loop=length(chn);
%             end
%         end
%     if loopsel==1
%         break;
%     end
% end
% m=5;
% dsmax=2;
% dcmax=4;
% t=((log(m*dcmax-((m*dcmax)/dsmax)-m+1))/log((dsmax-1)*(dcmax-1)))-1;