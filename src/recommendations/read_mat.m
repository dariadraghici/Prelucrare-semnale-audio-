function mat = read_mat(path)
    # TODO: Parse the .csv file and return the matrix of values (without row and column headers).
    fisier = fopen(path, 'r');
    
    % citesc header-ul
    fgetl(fisier);
    
    % initialiez matricea finala
    mat = [];
    
    % citesc fiecare linie din fisier
    while ~feof(fisier)
        linie = fgetl(fisier); % linia curenta
        elemente = strsplit(linie, ','); % despart elementele de pe linie
        valori = elemente(2:end); % ignor prima coloana (header)            
        numere = str2double(valori); % convertesc la numere
        mat = [mat; numere]; % adaug linia in matrice
    end
    % inchid fisierul
    fclose(fisier);
end