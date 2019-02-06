function [ y, Fs, q, Q, reconstructed ] = MulawQuant(inFile, outFile, N, Mu)

[y, Fs] = audioread(inFile);       %read audiofile
%       separate input into its 2 channels
y1 = y(:, 1);
y2 = y(:, 2);

%       apply Mulaw transformation
param11 = 1 + (Mu.*(abs(y1)./max(y1)));
param12 = 1 + (Mu.*(abs(y2)./max(y2)));
y1 = max(y1).*((log10(param11))./(log10(1 + Mu))).*sign(y1);
y2 = max(y2).*((log10(param12))./(log10(1 + Mu))).*sign(y2);

%       calculate step size
q(1) = (max(y1) - min(y1))/(2^N - 1);
q(2) = (max(y2) - min(y2))/(2^N - 1);
q = max(q);

%       quantize audio signal using mid-tread quantizer
Q(:,1) = round(y1./q);
Q(:,2) = round(y2./q);

%       reconstruct signal
temp_reconstructed = q.*Q;
param21 = (log10(1 + Mu)./max(y1)).*abs(temp_reconstructed(:,1));
param22 = (log10(1 + Mu)./max(y2)).*abs(temp_reconstructed(:,2));
reconstructed(:,1) = max(y1)/Mu.*((10.^param21) - 1).*sign(temp_reconstructed(:,1));
reconstructed(:,2) = max(y2)/Mu.*((10.^param22) - 1).*sign(temp_reconstructed(:,2));

%       save reconstructed audio to output file
% audiowrite(outFile, reconstructed, Fs)

end

