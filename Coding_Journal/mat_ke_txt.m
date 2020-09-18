% [K,N] = size(H);
% M = N - K;
% [m, n] = find(H);
% Hisi(1,:)=m;
% Hisi(2,:)=n;
% %get file name
% % G_file = strcat('./LDPC_gen_mat_',num2str(N),'_',num2str(K),'.txt');
% H_file = strcat('./LDPC_chk_mat_',num2str(N),'_',num2str(K),'.txt');
% %save G_matrix
% % fid1 = fopen(G_file,'w');
% % fprintf(fid1,'%d\t%d\r\n',Glist);
% % fclose(fid1);
% %save H_matrix
% fid2 = fopen(H_file,'w');
% fprintf(fid2,'%d\t%d\r\n',Hisi);
% fclose(fid2);

%===========================
[K,N] = size(G);
% [K,N] = size(H);
M = N - K;
[m, n] = find(G);
% [m, n] = find(H);

Gisi(1,:)=m;
Gisi(2,:)=n;
% Hisi(1,:)=m;
% Hisi(2,:)=n;
%get file name
G_file = strcat('./LDPC_gen_mat_',num2str(N),'_',num2str(K),'.txt');
% H_file = strcat('./LDPC_chk_mat_',num2str(N),'_',num2str(K),'.txt');
%save G_matrix
fid1 = fopen(G_file,'w');
fprintf(fid1,'%d\t%d\r\n',Gisi);
fclose(fid1);
%save H_matrix
% fid2 = fopen(H_file,'w');
% fprintf(fid2,'%d\t%d\r\n',Hisi);
% fclose(fid2);