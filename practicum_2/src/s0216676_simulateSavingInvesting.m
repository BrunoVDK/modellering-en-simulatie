function [yield, invested, value] = s0216676_simulateSavingInvesting(budget, rate, months)
    value = repelem(budget * 1.02 .^ (0:floor(months/12)), 1, 12); 
    invested = sum(value(1:months));
    for j = 13:12:months % Consider each month of january
    	win = sum(value(j-12:j-1) .* (((12:-1:1)/12) * (rate/100))); % Calculate savings
    	value(j) = value(j) + (win - 0.15 * (win > 980) * (win - 980));
        value(j-12:j) = cumsum(value(j-12:j)); % Accumulate sums
    end
    value = value(1:months); value(j:end) = cumsum(value(j:end));
    yield = value(months) / invested - 1;
end