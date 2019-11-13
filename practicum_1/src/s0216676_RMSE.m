function [err] = s0216676_RMSE(A,B)
    err = norm(A-B, 'fro') / sqrt(nnz(A));
end

