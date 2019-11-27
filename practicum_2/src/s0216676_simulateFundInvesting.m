function [yields,invested] = s0216676_simulateFundInvesting(budget, priceHistory, alpha, N)
    months = size(alpha, 2);
    [mu1,sigma1] = s0216676_estimateParameters(priceHistory(:,1));
    [mu2,sigma2] = s0216676_estimateParameters(priceHistory(:,2));
    yields = 1:N;
    for i = 1:N
        path1 = s0216676_simulateFundPath(priceHistory(end,1), mu1, sigma1, months);
        path2 = s0216676_simulateFundPath(priceHistory(end,2), mu2, sigma2, months);
        [yields(i),invested,~,~] = s0216676_simulateFundInvestingPath(budget, [path1 path2], alpha);
    end
end