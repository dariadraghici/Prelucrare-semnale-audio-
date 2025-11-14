function mono = stereo_to_mono(stereo)
    [numar_sampleuri, numar_canale] = size(stereo);

    % initializez vectorul mono cu numar_sampleuri de zerouri
    mono = zeros(numar_sampleuri, 1);

    % calculez mono dupa formula pentru fiecare sample
    for i = 1:numar_sampleuri
        suma = 0;
        for j = 1:numar_canale
            suma = suma + stereo(i, j);
        end
        mono(i) = suma / numar_canale;
    end

    % normez intre -1 si 1
    maxim_valoare = max(abs(mono));
    mono = mono / maxim_valoare;
end
