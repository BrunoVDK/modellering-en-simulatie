function [P] = s0216676_sparseModel(Uk,sk,Vk,A)
    [i,j,x] = find(A);
    for idx = 1:nnz(A)
        x(idx) = Uk(i(idx),:) .* sk' * Vk(j(idx),:)';
    end
    P = sparse(i, j, x);
end

