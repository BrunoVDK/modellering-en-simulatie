%% Initialisation
clear
clc
set(0, 'defaultFigurePosition', get(0, 'Screensize')); % Figuren vullen scherm
%% Opdracht 1
% [~,~,v] = s0216676_simulateSavingInvesting(100,5,25);
% disp(v)
%% Opdracht 2
yield = zeros(1,4);
figure; hold all;
for k = 1 : 4
    [yield(k), invested, value] = s0216676_simulateSavingInvesting(250, 2^(-2+k), 300);
    plot(value);
end
legend('0.5%', '1%', '2%', '4%', 'Location', 'NorthWest');
fprintf("Yield : %.4f\n", yield);
clear
%% Opdracht 3
% Dit bestand bevat de twee kolomvectoren EUN5 en VWRL. 
% Die eerste bevat de prijs (in e) gedurende de 129 opeenvolgende 
%  maanden van maart 2009 t.e.m. november 2019 van het obligatiefonds 
%  genaamd iShares Core e Corp Bond UCITS ETF (EUN5). De tweede vector 
%  bevat de prijzen van het aandelenfonds Vanguard FTSE All-World UCITS 
%  ETF (VWRL) voor de 77 opeenvolgende maanden van juli 2013 t.e.m. 
%  november 2019. De laatste rijen bevatten de meest recente prijzen.
load('Funds.mat')
%% Opdracht 4
[mu,sigma] = s0216676_estimateParameters(EUN5);
fprintf("Parameters EUN5 : mu = %i sigma = %i\n", mu, sigma);
[mu,sigma] = s0216676_estimateParameters(VWRL);
fprintf("Parameters VWRL : mu = %i sigma = %i\n", mu, sigma);
%% Opdracht 6
figure; hold all;
for i = 1:10
    plot(s0216676_simulateFundPath(74.19, mu, sigma, 60)); % Converted to euros (26/11/2019)
end
%% Opdracht 7
[f,x] = ecdf(log(VWRL(2:end) ./ VWRL(1:end-1)));
[f_norm] = normcdf(x, mu, sigma);
figure; hold all;
plot(x, f, x,f_norm);
legend('Log-Rendementen', 'Model', 'Location', 'NorthWest');
%% Opdracht 9 
% (a)
for jj = 1 : 2
    figure; hold all; 
    weights = [1 0.5 0];
    pathVWRL = s0216676_simulateFundPath(37.78, 7.8578e-03, 3.2775e-02, 120); 
    pathEUN5 = s0216676_simulateFundPath(128.25, 3.0856e-03, 3.0704e-02, 120); 
    P = [pathVWRL pathEUN5];
    for k = 1:3
        [~,~,value] = s0216676_simulateFundInvestingPath(400, P, weights(k) * ones(120,1));
        plot( sum(value,2) )
    end
    [~,~,value] = s0216676_simulateSavingInvesting(400, 2, 120);
    plot(value, '.-');
    legend('100% Aandelen', '50% Aandelen', '100% Obligaties', 'Spaarrekening', 'Location', 'NorthWest')
    grid on;
end
% (b)
figure; hold all;
[~,~,value,units] = s0216676_simulateFundInvestingPath(400, P, ((1 - (1:120)/240).^2)'); 
plot((units(2:end,:) - units(1:end-1,:)) .* P(2:end,:));
plot(sum((units(2:end,:) - units(1:end-1,:)) .* P(2:end,:),2))
title('Waarde van de incrementele investeringen');
legend('VWRL', 'EUN5', 'Totaal', 'Location', 'NorthWest');
grid on;