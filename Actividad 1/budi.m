function [xmin, fmin, iter, tiempo] = budi(f, a, b, tol, delta)
%BUDI Método de búsqueda dicotómica
%   Encuentra el mínimo local de f en el intervalo [a,b]
%   suponiendo que f es unimodal en dicho intervalo.
%
%   Entradas:
%       f     -> función
%       a, b  -> extremos del intervalo (unimodal)
%       tol   -> tolerancia
%       delta -> pequeño desplazamiento
%
%   Salidas:
%       xmin   -> aproximación del mínimo
%       fmin   -> valor de la función en xmin
%       iter   -> número de iteraciones
%       tiempo -> tiempo de ejecución

% ---------------- INICIALIZACIÓN ----------------
tic;
iter = 0;
maxIter = 1000;   % Por seguridad, para que no esté realizando iteraciones infinitas

% ---------------- BUCLE PRINCIPAL ----------------
while (b - a) > tol && iter < maxIter
    
    m = (a + b)/2;
    
    x1 = m - delta;
    x2 = m + delta;
    
    % Evaluaciones de la función en los extremos del intervalo
    f1 = f(x1);
    f2 = f(x2);
    
    % Modificación del intervalo
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