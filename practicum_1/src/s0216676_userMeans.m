function [mu] = s0216676_userMeans(A)
    mu = (sum(A) ./ sum(A~=0))';
end