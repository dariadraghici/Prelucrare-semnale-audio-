function signal = apply_reverb(signal, impulse_response)
    % fac mono
    impulse_response = stereo_to_mono(impulse_response);
    signal = stereo_to_mono(signal);

    % convolutia semnalului cu raspunsul la impuls
    % https://www.mathworks.com/matlabcentral/fileexchange/5703-fftconv
    signal = fftconv(signal, impulse_response);

    % normez
    signal = signal / max(abs(signal));
end