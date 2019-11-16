function [s] = s0216676_optimalCoefficients(Uk,Vk,A)
    [m,k] = size(Uk);
    [n,~] = size(Vk);
    B = sparse([], [], [], m * n, k, k * nnz(A)); % Allocate space
    for j = 1:k
        B(:,j) = reshape(s0216676_sparseModel(Uk(:,j), 1, Vk(:,j), A), [], 1); %#ok
    end
    % s = lsqminnorm(B , A(:));
    [s,~] = lsqr(B, A(:));
    % s = lsqr(B, A(:), [], 10);
end