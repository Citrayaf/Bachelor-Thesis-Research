function out=inverseJfunction(inputI)

% Approximation of J function 
% Source : Tad Matsumoto Lecture Note.
% created by Khoirul Anwar, Dr. Eng.
% Information Theory and Signal Processing Lab.
% Japan Advanced Institute of Science and Technology (JAIST)
% Hokuriku, JAPAN
% November 10, 2008.
% Modified: November 10, 2008.

H1=0.3073;
H2=0.8935;
H3=1.1064;

out=zeros(1,length(inputI));
for ii=1:length(inputI)
%out(ii)=(-(1/H1)*log(1-inputI(ii).^(1/H3))/log(2.0))^(1/(2*H2));
out(ii)=(-(1/H1)*log2(1-inputI(ii).^(1/H3)))^(1/(2*H2));
end
    
    
    