function [movieIDs,score] = s0216676_predictedBestMoviesForUser(R,Uk,sk,Vk,j)
    indices = setdiff(1:size(R,1), find(R(:,j)))';
    score = Uk(indices,:) * (sk .* Vk(j,:)');
    [score,permutation] = sort(score, 'descend');
    movieIDs = indices(permutation);
end