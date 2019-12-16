%% Part 1
% abs is om reële deel te nemen (amplitude)
% voor inversie heb je het originele complexe getal nodig => conj

load('dailyArea')

% https://www.mathworks.com/matlabcentral/answers/36430-plotting-the-frequency-spectrum
area = dailyArea(:, 4); % selecteer de data
X = fft(area); % Fourier-transformatie

% Time specifications
Fs = length(X);                % samples per second
dt = 1/Fs;                     % seconds per sample
StopTime = 1;                  % seconds
t = (0:dt:StopTime-dt)';
N = size(t,1);

%%Frequency specifications:
dF = Fs/N;                      % hertz
f = -Fs/2:dF:Fs/2-dF;           % hertz

% Amplitude
A = X;

%%Plot the spectrum:
figure;
plot(fftshift(f), abs(A));
xlabel('Frequency (in hertz)');
title('Magnitude Response');

[MaxA, MaxI] = maxk(A, 2);

disp(MaxA);
disp(MaxI);

% tien kleinste waarden
[MinA, MinI] = maxk(abs(A(2:floor(N/2))), 10);

nulfreq = A(1);

% symmetrie : links is complex toegevoegde van rechts
filteredA = zeros(1,N);
filteredA(1) = nulfreq;
filteredA(MinI+1) = A(MinI+1);
filteredA(N-MinI+1) = conj(A(MinI+1));

figure;
hold all;
plot(area);
plot(ifft(filteredA));
xlabel('Frequency (in hertz)');
title('Magnitude Response');

%% Part 2 (gray-scale only)
% https://www.youtube.com/watch?v=R-Qcd-a-DGA
load('Lighthouse')
figure;
imagesc(Z);
colormap('gray');
% FFT
F = fft2(Z);
figure;
imagesc(log(abs(fftshift(F)) + 1));
colormap('gray');
% Filter
% thresh = min(maxk(abs(F), 5000));
thresh = 0.002 * max(max(abs(F)));
F(abs(F) < thresh) = 0;
figure;
imagesc(abs(ifft2(F)));
colormap('gray');
clear

%% Part 3 (colors)
load('Lighthouse')
figure;
image(A);
for c = 1:3
    F = fft2(A(:,:,c));
    thresh = 0.001 * max(max(abs(F)));
    F(abs(F) < thresh) = 0;
    A(:,:,c) = abs(ifft2(F));
    figure;
    imagesc(A(:,:,c));
    colormap('gray');
end
figure;
image(A);
clear