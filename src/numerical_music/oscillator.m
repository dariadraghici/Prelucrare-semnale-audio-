function x = oscillator(freq, fs, dur, A, D, S, R)
  % freq - frecventa semnalului
  % fs - frecventa samples
  % dur - durata semnalului
  % A - durata attack
  % D - durata decay
  % S - nivelul de sustain
  % R - durata release

    % nr total de samples
    nr_samples = round(dur * fs); % ← poate fi exact în CSV

    % Vector de timp de la 0 la dur cu pas de 1/fs
    t = (0:nr_samples - 1)' / fs;

    % semnalul sin cu formula sin(2*pi*frequency*t)
    sin_wave = sin(2 * pi * freq * t);

    % samples pentru fazele A D si R cu floor
    nr_attack = floor(A * fs);
    nr_decay = floor(D * fs);
    nr_release = floor(R * fs);

    % samples pentru S = restul
    nr_sustain = nr_samples - nr_attack - nr_decay - nr_release;


    % envelopes
    % https://www.mathworks.com/help/matlab/ref/double.linspace.html
    % https://www.mathworks.com/matlabcentral/answers/887174-creating-ramp-signal-from-1-to-1

    envelope_attack = linspace(0, 1, nr_attack)';
    envelope_decay = linspace(1, S, nr_decay)';
    envelope_sustain = S * ones(nr_sustain, 1);
    envelope_release = linspace(S, 0, nr_release)';

    % https://www.mathworks.com/help/matlab/ref/vertcat.html
    envelope = vertcat(envelope_attack, envelope_decay, envelope_sustain, envelope_release);

    % rezultatul final
    x = sin_wave .* envelope;
end
