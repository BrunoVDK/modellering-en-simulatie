function [s] = s0216676_optimalCoefficients(Uk,Vk,A)
    B = repmat(spones(A(:)), 1, size(Uk,2));
    for j = 1:size(Uk,2)
        B(:,j) = reshape(s0216676_sparseModel(Uk(:,j), 1, Vk(:,j), A), [], 1);
    end
    [s,~] = lsqr(B, A(:));
    % s = lsqminnorm(B , A(:));
    % s = lsqr(B, A(:), [], 10);
end