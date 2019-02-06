function [ y, Fs, q, Q, reconstructed ] = UniformQuant(inFile, outFile, N)

[y, Fs] = audioread(inFile);       %read audiofile
%       separate input into its 2 channels
y1 = y(:, 1);
y2 = y(:, 2);

%       calculate step size
q = (max(y) - min(y))/(2^N - 1);
q = max(q);

%       quantize audio signal using mid-tread quantizer
Q(:,1) = round(y1/q);
Q(:,2) = round(y2/q);

%       reconstruct signal
reconstructed = q*Q;

%       save reconstructed audio to output file
% audiowrite(outFile, reconstructed, Fs)

end

