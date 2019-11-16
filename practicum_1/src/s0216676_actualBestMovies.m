function [movieIDs,score] = s0216676_actualBestMovies(R)
    [score,movieIDs] = sort(sum(R,2) ./ sum(R~=0,2), 'descend');
end

