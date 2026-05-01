function [xmin, fmin, iter, tiempo] = new(f, df, ddf, x0, tol)
%NEW Método de Newton para optimización unidimensional
%   Encuentra un mínimo local de f utilizando derivadas.
%
%   Entradas:
%       f     -> función
%       df    -> derivada primera
%       ddf   -> derivada segunda
%       x0    -> punto inicial
%       tol   -> tolerancia
%
%   Salidas:
%       xmin   -> aproximación del mínimo
%       fmin   -> valor de la función en xmin
%       iter   -> número de iteraciones
%       tiempo -> tiempo de ejecución


% ---------------- INICIALIZACIÓN ----------------
tic; %Cronometro
iter = 0;
maxIter = 1000;
x = x0;

% ---------------- BUCLE PRINCIPAL ----------------
while iter < maxIter
    
    g = df(x);     % derivada
    H = ddf(x);    % segunda derivada
    
    % Evitar división por cero
    if abs(H) < 1e-12
        warning('Segunda derivada cercana a cero. Se detiene el método.');
        break;
    end
    
    % Paso de Newton
    x_new = x - g/H;
    
    % Criterio de parada
    if abs(x_new - x) < tol
        break;
    end
    
    x = x_new;
    iter = iter + 1;
end

% ---------------- RESULTADO ----------------
xmin = x;
fmin = f(x);
tiempo = toc;

end