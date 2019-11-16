function [movieIDs,score] = s0216676_predictedBestMoviesForUser(R,Uk,sk,Vk,j)
    [m,~] = size(R);
    indices = setdiff(1:m,find(R(:,j)))';
    n = length(indices);
    score = zeros(n,1);
    x = sk .* Vk(j,:)';
    for i = 1:n
       score(i) = Uk(indices(i),:) * x;
    end
    [score,permutation] = sort(score, 'descend');
    movieIDs = indices(permutation);
end

