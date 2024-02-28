%goal, sample an IF sinewave at the nyquist rate and quantize it with 12
%bits of resolution. Plot the original and quantized signal and then
%compute the PSD and SNR 

F = 200e6;  % Frequency of the sine wave in Hz
Fs = 400e6;      % Sampling frequency in Hz
n_bits = 12;      % Number of bits of resolution
n_periods = 30;  % Number of periods for PSD calculation

% time vector
t = 0:1/Fs:(n_periods/F) - 1/Fs;
x = sin(2 * pi * F * t);
%quantize with 12 bit resolution 
x_max = max(abs(x));
quantization_levels = linspace(-x_max, x_max, 2^n_bits);
x_quantized = interp1(quantization_levels, quantization_levels, x, 'nearest', 'extrap');

% Plot the quantized signal
figure;
subplot(2,1,1);
plot(t, x, 'b', t, x_quantized, 'r', 'LineWidth', 1.5);
title('Original vs Quantized signal on interval');
xlabel('time');
ylabel('Volt');
legend('Orig', 'Quant');
grid on;

% Calculate and plot the PSD
subplot(2,1,2);
pwelch(x_quantized, [], [], [], Fs, 'centered');
title('PSD of quantized sine wave');
xlabel('Frequency MHz');
ylabel('Power');
grid on;
% compute and display signal to noise ratio
signal_power = rms(x)^2;
noise_power = rms(x - x_quantized)^2;
snr = 10 * log10(signal_power / noise_power);
disp("SNR:");
disp(snr);