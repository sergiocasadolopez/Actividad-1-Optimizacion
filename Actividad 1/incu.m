function [xmin, fmin, iter, tiempo] = incu(f, a, b, tol)
%INCU Método de interpolación cuadrática
%   Encuentra el mínimo local de f en el intervalo [a,b]
%   suponiendo que f es unimodal en dicho intervalo.
%
%   Entradas:
%       f     -> función
%       a, b  -> extremos del intervalo (unimodal)
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


% Tres puntos iniciales
x1 = a;
x3 = b;
x2 = (a + b)/2;

f1 = f(x1);
f2 = f(x2);
f3 = f(x3);

% ---------------- BUCLE PRINCIPAL ----------------
while (x3 - x1) > tol && iter < maxIter
    
    % Ajuste cuadrático (resolver sistema)
    X = [x1^2, x1, 1;
         x2^2, x2, 1;
         x3^2, x3, 1];
     
    Y = [f1; f2; f3];
    
    coeffs = X \ Y;  % [a2; a1; a0]
    
    % Mínimo de la parábola
    x_min = -coeffs(2)/(2*coeffs(1));
    
    % Evaluar en nuevo punto
    f_min = f(x_min);
    
    % ---------------- ACTUALIZACIÓN ----------------
    % Mantener 3 puntos alrededor del mínimo
    
    if x_min < x2
        if f_min < f2
            x3 = x2; f3 = f2;
            x2 = x_min; f2 = f_min;
        else
            x1 = x_min; f1 = f_min;
        end
    else
        if f_min < f2
            x1 = x2; f1 = f2;
            x2 = x_min; f2 = f_min;
        else
            x3 = x_min; f3 = f_min;
        end
    end
    
    iter = iter + 1;
end

% ---------------- RESULTADO ----------------
xmin = x2;
fmin = f2;
tiempo = toc;

end