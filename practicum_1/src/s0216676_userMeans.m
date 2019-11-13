function [mu] = s0216676_userMeans(A)
    mu = full(sum(A, 1) ./ sum(A ~= 0))';
end