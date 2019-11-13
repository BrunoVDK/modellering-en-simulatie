function [s] = s0216676_optimalCoefficients(Uk,Vk,A)
    nonzero = nnz(A);
    [m,k] = size(Uk);
    [n,~] = size(Vk);
    B = sparse([], [], [], m * n, k, k * nonzero); % Allocate space
    for j = 1:k
        temp = s0216676_sparseModel(Uk(:,j), 1, Vk(:,j), A);
        B(:,j) = temp(:); %#ok
    end
    s = lsqr(B, A(:));
end