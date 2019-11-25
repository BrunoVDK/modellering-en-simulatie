%% Initialisation
clc
clear
set(0, 'defaultFigurePosition', get(0, 'Screensize')); % Figuren vullen scherm
%% Opdracht 1
% [~,~,v] = s0216676_simulateSavingInvesting(100,5,25);
% disp(v)
%% Opdracht 2
yield = zeros(1,4);
figure; hold all;
for k = 1 : 4
    [yield(k), invested, value] = s0216676_simulateSavingInvesting(250, 2^(-2+k), 1000);
    plot(value);
end
legend('0.5%', '1%', '2%', '4%', 'Location', 'NorthWest');
fprintf("Yield : %.4f\n", yield);
%% Opdracht 3
