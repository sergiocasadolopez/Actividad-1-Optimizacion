function [xmin, fmin, iter, tiempo] = rein(f, a, b, tol)
%REIN Método de rectas inexactas
%   Encuentra el mínimo local de f en el intervalo [a,b]
%   suponiendo que f es unimodal.
%
%   Entradas:
%       f     -> función
%       a, b  -> extremos del intervalo
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

% ---------------- BUCLE PRINCIPAL ----------------
while (b - a) > tol && iter < maxIter
    
    % Puntos internos (división simple)
    x1 = a + (b - a)/3;
    x2 = b - (b - a)/3;
    
    f1 = f(x1);
    f2 = f(x2);
    
    % Actualización del intervalo
    if f1 < f2
        b = x2;
    else
        a = x1;
    end
    
    iter = iter + 1;
end

% ---------------- RESULTADO ----------------
xmin = (a + b)/2;
fmin = f(xmin);
tiempo = toc;

end