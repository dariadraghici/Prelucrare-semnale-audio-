function similarity = cosine_similarity(A, B)
  # TODO: Compute the cosine similarity between two column vectors.
    similarity = sum(A .* B);
    
    norma_A = sqrt(sum(A.^2));
    norma_B = sqrt(sum(B.^2));
    
    similarity = similarity / (norma_A * norma_B);
end