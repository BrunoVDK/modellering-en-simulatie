function [movieIDs,score] = s0216676_predictedBestMovies(Uk,sk,Vk)
    [m,k] = size(Uk);
    score = zeros(m, 1);
    for i = 1:k
        score = score + Uk(:,i) * sk(i) * sum(Vk(:,i));
    end
    [score, movieIDs] = sort(score / size(Vk,1), 'descend');
end