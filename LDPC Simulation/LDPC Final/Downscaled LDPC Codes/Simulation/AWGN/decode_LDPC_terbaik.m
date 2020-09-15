function [berr,Le_CND, vHat,iter] = decode_LDPC_2310(Le_CND, Lch, H, iteration,info,juminfo)

% Modified by Dr. Eng. Khoirul Anwar
% Telkom university, Bandung, Indonesia
% June 2017

% Log-domain sum product algorithm LDPC/LDGM decoder
%
%  rx        : Received signal vector (column vector)
%  H         : LDPC/LDGM matrix
%  N0        : Noise variance
%  iteration : Number of iteration
%
%  vHat      : Decoded vector (0/1)
%
berr2=[];
count=-1;
selisih=9999;
[n_parity n_blocklength] = size(H);

% Initialization



Pibetaij = zeros(n_parity, n_blocklength);

% Asscociate the L(ci) matrix with non-zero elements of H
for j = 1:n_blocklength
    
    % Find non-zero in the row
    r1 = find(H(:, j));
    
    for k = 1:length(r1)
        
        % Update VND to CND by summation of Le_cnd and others
        Le_VND_LDPC(r1(k), j) = sum(Le_CND(r1, j)) - Le_CND(r1(k), j)+Lch(j);
        if abs(Le_VND_LDPC(r1(k), j))> 10
            Le_VND_LDPC(r1(k), j)=sign(Le_VND_LDPC(r1(k), j))*10;
        end
        if abs(Le_VND_LDPC(r1(k), j)) < 1e-10
        Le_VND_LDPC(r1(k), j)=sign(Le_VND_LDPC(r1(k), j))*1e-10;
        end
    

    end % for k
    
end % for j
%-------------------------------------------------------------------------------------------
% Get the sign and magnitude of L(qij)
%-------------------------------------------------------------------------------------------

LQij = Le_VND_LDPC;

% Get non-zero elements
% Menentukan posisi dalam matrix-nya
[r, c] = find(H);

% Iteration
for n = 1:iteration
    iter=n;
    
    % Get the sign and magnitude of L(qij)
    alphaij = sign(Le_VND_LDPC);
    betaij = abs(Le_VND_LDPC);
    
    %mencari nilai boxplus per VND per edges lalu disimpan dalam matriks Pibetaij
    
    for l = 1:length(r)
        M=betaij(r(l),c(l));
    if abs(M)> 10
            M=sign(M)*10;
    end
    if abs(M) < 1e-10
            M=sign(M)*1e-10;
    end

    Pibetaij(r(l), c(l)) = log((exp(M) + 1)/...
            (exp(M) - 1));
        
        
    end
    
    
    % ----- Horizontal step -----
    % untuk check nodes
    for i = 1:n_parity
        
        % Find non-zeros in the column
        c1 = find(H(i, :));
        
        % Get the summation of Pi(betaij))
        %-------------------------------------------------------------------------------------------
        % Update CND to VND by boxplus of Le_vnd and others
        %-------------------------------------------------------------------------------------------
        
        for k = 1:length(c1)
            % operasi matetamis per CND
          
            
            % Summation of Pi(betaij)\c1(k)
            sumOfPibetaij =  sum(Pibetaij(i, c1)) - Pibetaij(i, c1(k));
%            
            L=sumOfPibetaij;
            if abs(L)> 10
                L=sign(L)*10;
            end
            if abs(L) < 1e-10
                L=sign(L)*1e-10;
            end
            
            PiSumOfPibetaij =log((exp(L) + 1)/(exp(L) - 1));
%             
            % Multiplication of alphaij\c1(k) (use '*' since alphaij are -1/1s)
            prodOfalphaij = prod(alphaij(i, c1))*alphaij(i, c1(k));
            
            % Update L(rji)
            Le_CND(i, c1(k)) = prodOfalphaij*PiSumOfPibetaij;
%            
            
            
            
        end % for k
        
    end % for i
    
    % ------ Vertical step ------
    % Untuk variable node
    for j = 1:n_blocklength
        
        % Find non-zero in the row
        r1 = find(H(:, j));
        
        for k = 1:length(r1)
            
            % Update L(qij) by summation of L(rij)\r1(k)
            Le_VND_LDPC(r1(k), j) = sum(Le_CND(r1, j)) - Le_CND(r1(k), j)+Lch(j);
%            
        end % for k
        
        % Get L(Qi)
        La_VND_LDPC(j) = sum(Le_CND(r1, j))+Lch(j);
%        
        % Decode L(Qi)
        if La_VND_LDPC(j) < 0
            vHat(j) = 1;
        else
            vHat(j) = 0;
        end
        
    end % for j
    
    berr2 =[berr2 sum(abs(vHat(1:juminfo)-info))];%Count number of errors;
        
    if berr2(n)<selisih 
       selisih=berr2(n);
    else
       count=count+1;
    end
    
    if count==5
        berr=min(berr2);
        break
    end
    
end % for n


