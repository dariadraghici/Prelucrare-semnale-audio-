function y_interp = P_spline (coef, x, x_interp)
	% si(x)   = ai + bi(x - xi) + ci(x - xi)^2 + di(x - xi)^3, i = 0 : n - 1
	% coef = [a0, b0, c0, d0, a1, b1, c1, d1, ..., an-1, bn-1, cn-1, dn-1]
	% x = [x0, x1, ..., xn]
	% y_interp(i) = P_spline(x_interp(i)), i = 0 : length(x_interp) - 1
	% Be careful! Indexes in Matlab start from 1, not 0
	% TODO: Calculate y_interp using the Spline coefficients

    % initializez vectorul rezultat
    y_interp = zeros(length(x_interp), 1);
    
    % parcurg toate punctele de interpolare
    for i = 1:length(x_interp)
        x_val = x_interp(i);
        
        interval = 1;
        while interval < length(x) && x_val > x(interval+1) % caut intervalul
            interval = interval + 1;
        end
        
        idx = 4*(interval-1) + 1;
        a = coef(4*(interval-1) + 1);
        b = coef(4*(interval-1) + 2);
        c = coef(4*(interval-1) + 3);
        d = coef(4*interval);
        
        distanta = x_val - x(interval); % distanta dintre x_val si capatul din stanga al intervalului 
        y_interp(i) = a + b*distanta + c*distanta^2 + d*distanta^3;
    end
end