% Reading data
clear;
FILENAME = 'signal.wav';
YRaw = wavread(FILENAME);

% Sampling data because we don't need very high resoultion
scale = 20;
for i = 1:(length(YRaw) / scale)
    Y(i) = 0.5 * (YRaw(i * scale, 1) + YRaw(i * scale, 2));
end

% Plots sampled data
plot(Y);

% Calculates and plots frequency
YFrequency = fft(Y);
figure;
plot(abs(YFrequency));

% Calculates and plots the power
power = Y.^2;
figure;
plot(power);
