function recoms = recommendations(path, liked_theme, num_recoms, min_reviews, num_features)
  # TODO: Get the best `num_recoms` recommandations similar with 'liked_theme'.
    A = read_mat(path); % citesc matricea din fisier
    A = preprocess(A, min_reviews); % elimin utilizatorii care au mai putin de min_reviews review
    [~, ~, V] = svds(A, num_features); % aplic SVD
    nr_teme = size(V, 1); % nr de teme
    similaritati = zeros(nr_teme, 1); % vector de similaritati
    vector_preferat = V(liked_theme, :)'; % vectorul temei preferate
    
    for i = 1:nr_teme
        if i == liked_theme
            similaritati(i) = -Inf; % exclud tema preferata
        else
            vector_curent = V(i, :)';
            similaritati(i) = cosine_similarity(vector_preferat, vector_curent); % calculez similaritatea
        end
    end
    
    [~, indici_sortati] = sort(similaritati, 'descend'); % ordonez temele dupa similaritate
    recoms = indici_sortati(1:num_recoms); % aleg primele num_recoms teme
    recoms = recoms';
end