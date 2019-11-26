function [path] = s0216676_simulateFundPath(initialPrice, mu, sigma, months)
    alpha = mu - 0.5 * sigma^2;
    path = [initialPrice 2:months];
    for t = 2:months
        path(t) = path(t-1) * exp(alpha + sigma * randn);
    end
end