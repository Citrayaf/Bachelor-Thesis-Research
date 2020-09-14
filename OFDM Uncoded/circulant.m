% created by Khoirul Anwar
% Information Theory and Signal Processing Lab
% Japan Advanced Institute of Science and TechnologyS

function output=circulant(input)

input=reshape(input,[],1);
L=length(input);
%indeks=gallery('circul',1:L);
for ii=1:L
    %output(:,ii)=input(indeks(ii,:));
    output(:,ii)=circshift(input,ii-1);
end


