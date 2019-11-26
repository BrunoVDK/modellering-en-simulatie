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
%% Opracht 7
