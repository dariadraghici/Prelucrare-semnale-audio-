function y_interp = P_vandermonde (coef, x_interp)
	% P_vandermonde(x) = a0 + a1 * x + a2 * x^2 + ... + an * x^n
	% coef = [a0, a1, a2, ..., an]'
	% y_interp(i) = P_vandermonde(x_interp(i)), i = 0 : length(x_interp) - 1
	% TODO: Calcualte y_interp using the Vandermonde coefficients

    % initializez vectorul rezultat
    y_interp = zeros(length(x_interp), 1);
    
    n = length(coef) - 1; % grad polinom
    
    % parcurg toate punctele de interpolare
    for i = 1:length(x_interp)
        val = coef(n+1); % coeficientul pentru x^n
        for j = n:-1:1
            val = val .* x_interp(i) + coef(j); % a_0 + x(a_1 + x(a_2 + x(a_3 +...+ x(a_n-1 + x⋅a_n)..))
        end
        y_interp(i) = val;
    end
end