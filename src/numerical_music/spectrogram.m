function [S, f, t] = spectrogram(signal, fs, window_size)
    % am folosit floor precum precizat la 1.
    numar_ferestre = floor(length(signal) / window_size);

    % dimensiunea FFT dubla fata de cea a ferestrei
    % https://www.mathworks.com/help/matlab/ref/fft.html
    dimensiune_fft = 2 * window_size;

    % initializez matricea spectrogramei (frecv x timp)
    % are linii cat nr de componente de frecv unice (simetrie complex-conjugata) si coloane cat nr de ferestre (timp)
    S = zeros(dimensiune_fft / 2, numar_ferestre);

    % https://www.mathworks.com/help/signal/ref/hann.html
    % cu functia hann nu da rezultatul corect pentru ca impartirea se face doar la window_size cand ar trebui la window_size - 1
    % https://www.mathworks.com/matlabcentral/answers/41903-hanning-window
    h = hanning(window_size);

    % pentru fiecare fereastra
    for i = 1:numar_ferestre
        % fereastra curenta
        inceput = (i - 1) * window_size + 1;
        sfarsit = inceput + window_size - 1;

        % segment 
        window_segment = zeros(window_size, 1);
        for j = 1:window_size
            window_segment(j) = signal(inceput + j - 1);
        end

        % fereastra Hann pentru a reduce efectul de discontinuitate (margini)
        segment_Hann_window = window_segment .* h;

        % fac Fast Fourier transform pe rezultatul obtinut
        fft_rezultat = fft(segment_Hann_window, dimensiune_fft);

        % doar prima jumatate (magnitudine) pt ca pe un semnal real rezultatul FFT are simetrie complex-conjugata
        for j = 1:dimensiune_fft / 2
            S(j, i) = abs(fft_rezultat(j));
        end
    end

    % vector frecvente
    f = zeros(dimensiune_fft / 2, 1);
    for i = 0:(dimensiune_fft / 2 - 1)
        % frecventa curenta calculata cu frecventa de esantionare fs
        f(i + 1) = i * fs / dimensiune_fft;
    end

    % vector timp
    t = zeros(numar_ferestre, 1);
    for i = 0:(numar_ferestre - 1)
        % timpul curent calculat cu fs
        t(i + 1) = i * window_size / fs;
    end
end