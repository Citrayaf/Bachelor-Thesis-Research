
load Hs1-2(4-9){1-60}.mat

[p n] = size(H);

k = n-p;

H1 = H(:, 1:k);

H2 = H(:, (k+1):n);

Hb = [H2 H1];


[P, rearranged_cols] = H2P(Hb);
G = [eye(k) P']; 

save('Matrix_G', 'G');

% checking G
mod(G*H',2)
% If the result not zeros, G and H can't correct the error