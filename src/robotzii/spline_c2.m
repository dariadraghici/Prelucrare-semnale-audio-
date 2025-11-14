function coef = spline_c2(x, y)
    % nr de intervale (n+1 puncte)
    n = length(x) - 1;
    
    % nr de coeficienti 4 (a, b, c, d) pe interval
    nr_coef = 4 * n;
    
    % matricele sistemului de ecuatii
    A = zeros(nr_coef, nr_coef);
    b = zeros(nr_coef, 1);

    % TOOD 1: si(xi) = yi, i = 0 : n - 1
    for i = 1:n
        A(i, 4*(i-1) + 1) = 1; % a_i = 1
        b(i) = y(i);
    end

    % TODO 2: s_n-1(xn) = yn
    dif = x(n+1) - x(n); % lungime interval
    A(n+1, 4*(n-1) + 1) = 1; % a_n-1
    A(n+1, 4*(n-1) + 2) = dif; % b_n-1 * dif
    A(n+1, 4*(n-1) + 3) = dif^2; % c_n-1 * dif^2
    A(n+1, 4*n) = dif^3; % d_n-1 * dif^3
    b(n+1) = y(n+1);

    % TODO 3: si(x_i+1) = s_i+1(x_i+1), i = 0 : n - 1
    for i = 1:n-1
        dif = x(i+1) - x(i); % lungime interval
        A(n + 1 + i, 4*(i-1) + 1) = 1; % a_i = 1
        A(n + 1 + i, 4*(i-1) + 2) = dif; % b_i * dif
        A(n + 1 + i, 4*(i-1) + 3) = dif^2; % c_i * dif^2
        A(n + 1 + i, 4*i) = dif^3; % d_i * dif^3
        A(n + 1 + i, 4*i + 1) = -1; % -a_i+1
        b(n + 1 + i) = 0;
    end

    % TODO 4: si'(x_i+1) = s_i+1'(x_i+1), i = 0 : n - 1
    for i = 1:n-1
        dif = x(i+1) - x(i); % lungime interval
        A(2*n + i, 4*(i-1) + 2) = 1; % b_i
        A(2*n + i, 4*(i-1) + 3) = 2*dif; % c_i * 2*dif
        A(2*n + i, 4*i) = 3*dif^2; % d_i * 3*dif^2
        A(2*n + i, 4*i + 2) = -1; % -b_i+1
        b(2*n + i) = 0;
    end

    % TODO 5: si''(x_i+1) = s_i+1''(x_i+1), i = 0 : n - 1
    for i = 1:n-1
        dif = x(i+1) - x(i); % lungime interval
        A(3*n + i - 1, 4*(i-1)+3) = 2; % 2*c_i
        A(3*n + i - 1, 4*i) = 6*dif; % 6*d_i * dif
        A(3*n + i - 1, 4*i + 3) = -2; % -2*c_i+1
        b(3*n + i - 1) = 0;
    end

    % TODO 6: s0''(x0) = 0
    A(4*n - 1, 3) = 2; % 2*c0
    b(4*n - 1) = 0;
    
    % TODO 7: s_n-1''(x_n) = 0
    dif = x(n+1) - x(n); % lungime interval
    A(4*n, 4*(n-1) + 3) = 2; % 2*c_n-1
    A(4*n, 4*n) = 6*dif;  % 6*d_n-1 * h
    b(4*n) = 0;

    % Solve the system of equations
    coef = inv(A) * b;
end