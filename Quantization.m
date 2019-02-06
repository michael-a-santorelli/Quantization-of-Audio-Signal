%% Quantization
%       set number of quantization bits
N = 8;

%% Uniform Quantization
%       obtain uniform quantization of audio signal
[ Original, Fs, q, Q, reconstructed_uniform ] = UniformQuant('test.wav', 'output.wav', N);

%       play audio of original or reconstructed audio signal
% sound(Original, Fs)
% sound(reconstructed_uniform, Fs)

%       plot original and reconstructed audio signals
figure
hold on
plot(Original)
plot(reconstructed_uniform)
hold off
title('Orignal and Reconstructed Audio Signal Waveform', 'FontWeight', 'Normal')
legend('Orignal Audio Channel 1', 'Orignal Audio Channel 2', 'Reconstructed  Audio Channel 1', 'Reconstructed Audio Channel 2')

%       calculate MSE of uniform quantization
MSE_uniform_quant = (1/length(Original))*sum((reconstructed_uniform - Original).^2);
MSE_uniform_quant = (MSE_uniform_quant(1) + MSE_uniform_quant(2))/2;

%% Mulaw Quantization
%       set mulaw factor
Mu = 100;

%       obtain mulaw quantization of audio signal
[ Original, Fs, q, Q, reconstructed_mulaw ] = MulawQuant('test.wav', 'output.wav', N, Mu);

%       play audio of original or reconstructed audio signal
% sound(Original, Fs)
% sound(reconstructed_mulaw, Fs)

%       plot original and reconstructed audio signals
figure
hold on
plot(Original)
plot(reconstructed_mulaw)
hold off
title('Orignal and Reconstructed Audio Signal Waveform', 'FontWeight', 'Normal')
legend('Orignal Audio Channel 1', 'Orignal Audio Channel 2', 'Reconstructed  Audio Channel 1', 'Reconstructed Audio Channel 2')

%       calculate MSE of mulaw quantization
MSE_mulaw_quant = (1/length(Original))*sum((reconstructed_mulaw - Original).^2);
MSE_mulaw_quant = (MSE_mulaw_quant(1) + MSE_mulaw_quant(2))/2;

%% Comparison
figure
hold on
plot(Original)
plot(reconstructed_uniform)
plot(reconstructed_mulaw)
hold off
title('Comparison of Original Uniform, and Mulaw Quantized Signals', 'Fontweight', 'Normal')
axis([2*10^4 (2.2*10^4) 0 0.35])
legend('Orignal Audio Channel 1', 'Orignal Audio Channel 2', 'Uniform Reconstructed Audio Channel 1', 'Uniform Reconstructed Audio Channel 2', 'Mulaw Reconstructed Audio Channel 1', 'Mulaw Reconstructed Audio Channel 2')
