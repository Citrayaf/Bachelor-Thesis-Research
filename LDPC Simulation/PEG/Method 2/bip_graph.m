clc
clear all

%Draw bipartit graph

% Make a random MxN adjacency matrix
load Matrix_H.mat

[m, n] =  size(H);

% Expand out to symmetric (M+N)x(M+N) matrix
big_a = [zeros(m,m), H;
         H', zeros(n,n)];     
g = graph(big_a);
% Plot
h = plot(g);
% Make it pretty
h.XData(1:m) = 1;
h.XData((m+1):end) = 2;
h.YData(1:m) = linspace(0,1,m);
h.YData((m+1):end) = linspace(0,1,n);