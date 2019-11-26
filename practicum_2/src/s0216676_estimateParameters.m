function [mu,sigma] = s0216676_estimateParameters(s)
    rendements = log(s(2:end) ./ s(1:end-1)); % Base doesn't matter
    sigma = std(rendements);
    mu = mean(rendements) + 0.5 * sigma^2;
end

