clear all;
clc;
% function H = DVBT2Lcode(R) 
R=1/2; %choose the LDPC codes rate
 
lenCodeWord = 16200;  % Length of codeword for DVB-T2 
NB = 360;  % Node indices 

% Downscaled factor
sf = [30]; %Scaling factor
%Let it empty if make the original LDPC codes
%Scaling factor will be the dividen of the original LDPC codes

if lenCodeWord == 16200
    rates = [1/4 1/3 2/5 1/2 3/5 2/3 3/4 4/5 5/6];
    realRates = [1/5 1/3 2/5 4/9 3/5 2/3 11/15 7/9 37/45];
    qval=[36 30 27 25 18 15 12 10 8];
    mark = find(R==rates,1);
    realR=realRates(mark);
    q=qval(mark);
    numInfoBits = lenCodeWord * realR; 
    numParityBits = lenCodeWord - numInfoBits; 
else
    numInfoBits = lenCodeWord * R; 
    numParityBits = lenCodeWord - numInfoBits;
    q = 0;
end
 
[ct1, ct2] = getchecknodetable(R, lenCodeWord); 

if not(isempty(sf))
    [r_c1, c_c1] = size(ct1);
    [r_c2, c_c2] = size(ct2);    
    k = NB/sf;
    nw = numParityBits/sf;
    
    for j=1:r_c1
        for k=2:k
            ct1(j,:)=mod((ct1(j,:)+(r_c1+r_c2)*(k-1)),nw); 
        end
    end
           
    for j=1:r_c2
        for k=2:k
            ct2(j,:)=mod((ct2(j,:)+150*(k-1)),nw); 
        end
    end
    
    lenCodeWord = lenCodeWord/sf;
    numParityBits = numParityBits/sf;
    numInfoBits = numInfoBits/sf;
    NB = k;
    
end
 
ck1 = nodeindices(ct1, numParityBits, NB, q, lenCodeWord); 
ck2 = nodeindices(ct2, numParityBits, NB, q, lenCodeWord); 
 
d = [size(ck1,2) size(ck1,1) size(ck2,2) size(ck2,1) numParityBits-1 2 1 1]; 
r = [ck1(:); ck2(:); 0; reshape(ones(2,1)*(1:numParityBits-1),[],1)]; 
S = zeros(length(r),1); 
numGroup = length(d)/2; 
n = 0; 
ncol = 1; 

for i = 1:numGroup 
    p = d(2*i-1)*d(2*i); 
    S(n+1:n+p) = reshape(ones(d(2*i),1)*(ncol:ncol+d(2*i-1)-1),p,1); 
    ncol = ncol + d(2*i-1); 
    n = n + p; 
end 
 
% Parity check matrix (sparse) for DVB-T2 
H = logical(sparse(double(r+1), S, 1));
Hb = full(H);
% dvi = sum(H,1);           % <-- to sum up the dc and dv
% dci = sum(H,2)';

H1=Hb(:,1:numInfoBits);
H2=Hb(:,(numInfoBits+1):lenCodeWord);
H3=[H2 H1];
 
[p n] = size(H3);
k = n-p;
[P,rearranged_cols]=H2P(H3);
G = [eye(k) P'];

spy(Hb);
%  dvi = sum(H,1);           % <-- to sum up the dc and dv
%  dci = sum(H,2)';
