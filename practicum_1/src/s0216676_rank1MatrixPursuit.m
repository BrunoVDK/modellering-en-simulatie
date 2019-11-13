function [U,s,V,rmse] = s0216676_rank1MatrixPursuit(R,k,T)
  [m, n] = size(R);
  rmse = zeros(k,1);
  U = zeros(m,k);
  V = zeros(n,k);
  U(:,1) = ones(m,1);
  V(:,1) = s0216676_userMeans(R);
  S = s0216676_sparseModel(U(:,1),1,V(:,1),R);
  P = s0216676_sparseModel(U(:,1),1,V(:,1),T);
  E = R - S;
  rmse(1) = s0216676_RMSE(T,P);
  for j = 2 : k 
    [u,~,v] = svds(E,1);
    U(:,j) = u;
    V(:,j) = v;
    s = s0216676_optimalCoefficients(U(:,1:j),V(:,1:j),R);
    S = s0216676_sparseModel(U(:,1:j),s,V(:,1:j),R);
    P = s0216676_sparseModel(U(:,1:j),s,V(:,1:j),T);
    E = R - S;
    rmse(j) = s0216676_RMSE(T,P);
  end
end
