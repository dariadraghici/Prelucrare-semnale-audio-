function reduced_mat = preprocess(mat, min_reviews)
  # TODO: Remove all user rows from `mat` that have strictly less then `min_reviews` reviews.
    [randuri, coloane] = size(mat);
    nr_de_reviewuri = zeros(randuri, 1);
    
    for i = 1:randuri
        cnt = 0;
        for j = 1:coloane
            if mat(i,j) ~= 0  % review existent
                cnt = cnt + 1;
            end
        end
        nr_de_reviewuri(i) = cnt; % nr de reviewuri pentru utilizatorul i
    end
    
    % randuri care au mai mult de min_reviews reviewuri
    utilizatori_buni = false(size(nr_de_reviewuri));

    % pentru fiecare utilizator, verific daca are mai mult de min_reviews reviewuri
    for i = 1:length(nr_de_reviewuri)
        if nr_de_reviewuri(i) >= min_reviews
            utilizatori_buni(i) = true;
        else
            utilizatori_buni(i) = false;
        end
    end
    
    reduced_mat = mat(utilizatori_buni, :);
end