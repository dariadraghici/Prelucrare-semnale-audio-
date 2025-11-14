function signal = high_pass(signal, fs, cutoff_freq)
    N = length(signal);

    % transformata Fourier
    signal = fft(signal);

    % vectorul de frecvente
    f = (0:N-1)' * fs / N;

    % masca care e 1 pentru frecvențe > cutoff_freq și < fs - cutoff_freq
    mask = (f > cutoff_freq) & (f < fs - cutoff_freq);

    % aplic masca
    signal = signal .* mask;

    % inversa FFT
    % https://www.mathworks.com/help/matlab/ref/ifft.html
    % https://www.mathworks.com/matlabcentral/answers/1958349-why-am-i-getting-complex-values-with-ifft
    signal = real(ifft(signal));

    signal = signal / norm(signal);
end
