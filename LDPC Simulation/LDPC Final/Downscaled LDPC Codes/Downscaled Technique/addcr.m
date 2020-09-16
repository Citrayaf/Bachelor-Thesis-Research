function A = addcr(c, r) 
M = length(c);
N = length(r); 
A = zeros(M, N); 
for m = 1:M 
    A(m, :) = r + c(m); 
end 