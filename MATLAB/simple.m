% Reading data
clear all;
close all;
FILENAME = 'signal.wav';
TMAX = 6 * 60 + 26;
YRaw = wavread(FILENAME);

% Sampling data because we don't need very high resolution
scale = 20;
for i = 1:(length(YRaw) / scale)
    Y(i) = 0.5 * (YRaw(i * scale, 1) + YRaw(i * scale, 2));
end
N = length(Y);

% Plots sampled data
figure;
plot(Y);
title('Sleep signal');

% Calculates and plots frequency
YFrequency = fft(Y);
figure;
plot(abs(YFrequency));
title('Frequency');

% Calculates and plots the power
power = Y.^2;
figure;
plot(power);
title('Power');

% Apnea detection
threshold = 0.005;
interval = 3;
apnea = detectApnea(power, TMAX, threshold, interval);
t = 0:(TMAX / N):(TMAX - TMAX / N);
figure;
subplot(2, 1, 1);
plot(t, Y);
title('Sleep signal');
subplot(2, 1, 2);
plot(t, apnea);
title('Apnea detection');