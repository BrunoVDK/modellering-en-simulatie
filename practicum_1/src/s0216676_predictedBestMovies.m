function [movieIDs,score] = s0216676_predictedBestMovies(Uk,sk,Vk)
    [m,~] = size(Uk); 
    [n,~] = size(Vk);
    score = zeros(n, 1);
    for i = 1:m
        acc = 0;
        x = Uk(i,:) .* sk';
        for j = 1:n
            acc = x * Vk(j,:)' + acc;
        end
        score(i) = acc / n;
    end
    [score, movieIDs] = sort(score, 'descend');
end

