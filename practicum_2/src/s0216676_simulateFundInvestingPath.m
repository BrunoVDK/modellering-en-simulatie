function [yield, invested, value, units] = s0216676_simulateFundInvestingPath(budget,pricePath,alpha)
    months = size(alpha,1);
    budgets = repelem(budget * (1.02 .^ (0:floor(months/12))'), 12, 2);
    invested = sum(budgets(1:months,1));
    units = (budgets(1:months,:) .* [alpha (1-alpha)] - 6) / 1.0035;
    for i = 1:2
        units(units(:,i) < 0, 3-i) = (budgets(units(:,i) < 0) - 6) / 1.0035;
        units(units(:,i) < 0, i) = 0;
    end
    units = cumsum(units ./ pricePath);
    value = units .* pricePath;
    yield = sum(value(end,:)) / invested - 1;
end