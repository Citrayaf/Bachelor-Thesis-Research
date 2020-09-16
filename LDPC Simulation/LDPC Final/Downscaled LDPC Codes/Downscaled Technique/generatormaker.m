
clear all;
clc;
b=DVBT2code(1/2);
H=[0,1,1,1,1,0,0
   1,0,1,1,0,1,0
   1,1,0,1,0,0,1];
%  H=full(b);
H1=H(:,1:4);
H2=H(:,5:7);
%  H1=H(:,1:90);
%  H2=H(:,91:180);
%  H3=[H2 H1];

[p n] = size(H);
k = n-p;
[P,rearranged_cols]=H2P(H);
G = [P' eye(k)]; 