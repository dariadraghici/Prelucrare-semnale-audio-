function [x, y] = parse_data(filename)
    % TODO 1: Open the file for reading
    fisier = fopen(filename, 'r');
    
    % TODO 2: Read n, x, y from the file
    n = fscanf(fisier, '%d', 1);
    x = fscanf(fisier, '%f', n+1);
    y = fscanf(fisier, '%f', n+1);
    
    % TODO 3: Close the file
    fclose(fisier);
end