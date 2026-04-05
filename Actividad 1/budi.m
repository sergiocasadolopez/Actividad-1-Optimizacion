function xmin = budi(f, a, b, tolerancia, epsilon, maxIter)
% BUSQUEDA DICOTOMICA PARA MINIMO LOCAL
% Esta funcion supone que el intervalo de entrada contiene el minimo local
% que se esta buscando
% f  -> función
% [a,b] -> intervalo inicial
% tolerancia  -> tolerancia
% epsilon -> pequeño desplazamiento
% maxIter -> máximo iteraciones

iter = 0;

while (b - a) > tolerancia && iter < maxIter
    
    %Punto medio del intervalo
    m = (a + b)/2;
    
    %Extremos del intervalo
    x1 = m - epsilon/2;
    x2 = m + epsilon/2;
    
    % Evaluar función en los puntos x1 y x2
    f1 = f(x1);
    f2 = f(x2);

    if f1<f2
        a = x1; % Actualizar el límite inferior
    else
        b = x2; % Actualizar el límite superior
    end
    
    %Conteo de iteraciones
    iter = iter + 1;
end

xmin = (a + b)/2;

fprintf('Mínimo aproximado en x = %.6f\n', xmin);
fprintf('Valor f(x) = %.6f\n', f(xmin));
fprintf('Iteraciones = %d\n', iter);

end