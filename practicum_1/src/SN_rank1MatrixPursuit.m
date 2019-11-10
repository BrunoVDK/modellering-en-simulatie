function [U,s,V,rmse] = SN_rank1MatrixPursuit(R,k,T)
  [m, n] = size(R);
  rmse = zeros(k,1);
  U = zeros(m,k);
  V = zeros(n,k);
  U(:,1) = ones(m,1);
  V(:,1) = SN_userMeans(R);
  S = SN_sparseModel(U(:,1),1,V(:,1),R);
  P = SN_sparseModel(U(:,1),1,V(:,1),T);
  E = R - S;
  rmse(1) = SN_RMSE(T,P);
  for j = 2 : k 
    [u,~,v] = svds(E,1);
    U(:,j) = u;
    V(:,j) = v;
    s = SN_optimalCoefficients(U(:,1:j),V(:,1:j),R);
    S = SN_sparseModel(U(:,1:j),s,V(:,1:j),R);
    P = SN_sparseModel(U(:,1:j),s,V(:,1:j),T);
    E = R - S;
    rmse(j) = SN_RMSE(T,P);
  end
end
