clc; clear; close all;

% ---------------- PARÁMETROS GENERALES ----------------

tol = 1e-5;
delta = 1e-4;

% -------------- DEFINICIÓN DE FUNCIONES ----------------

f1 = @(x) x.^6 - 7*x.^3 + 7;
f2 = @(x) log(x) - sin(x);
f3 = @(x) exp(cos(x)) - x;
f4 = @funcionrr;

funciones = {f1, f2, f3, f4};
nombres = {'f1','f2','f3','funcionrr'};
n = length(funciones);

% ------------ DIBUJO DE LA CUARTA FUNCIÓN -------------

% x = linspace(1,4,50);
% y = arrayfun(f4, x);
% 
% plot(x,y)
% grid on
% title('Funcion numérica en [1,4]')

% ---------------- INTERVALOS ----------------
intervalos = [
    1   2;
    7   8;
    4   5;
    2   3
];

% ---------------- RESULTADOS ----------------
res_budi = zeros(n,4);
res_incu = zeros(n,4);
res_new  = zeros(n,4);
res_rein = zeros(n,4);

%%
% ---------------- BÚSQUEDA DICOTÓMICA ----------------
fprintf('==============================\n');
fprintf('MÉTODO DE BÚSQUEDA DICOTÓMICA\n');
fprintf('==============================\n\n');

for i = 1:n

    f = funciones{i};
    a = intervalos(i,1);
    b = intervalos(i,2);
    
    [xmin, fmin, iter, tiempo] = budi(f, a, b, tol, delta);
    
    res_budi(i,:) = [xmin, fmin, iter, tiempo];
    
    fprintf('Función: %s\n', nombres{i});
    fprintf('Intervalo: [%.2f, %.2f]\n', a, b);
    fprintf('xmin = %.6f\n', xmin);
    fprintf('f(xmin) = %.6f\n', fmin);
    fprintf('Iteraciones = %d\n', iter);
    fprintf('Tiempo = %.6f s\n\n', tiempo);
end

% ---------------- INTERPOLACIÓN CUADRÁTICA ----------------
fprintf('==============================\n');
fprintf('MÉTODO DE INTERPOLACIÓN CUADRÁTICA\n');
fprintf('==============================\n\n');

for i = 1:n
    f = funciones{i};
    a = intervalos(i,1);
    b = intervalos(i,2);

    [xmin, fmin, iter, tiempo] = incu(f, a, b, tol);

    res_incu(i,:) = [xmin, fmin, iter, tiempo];

    fprintf('Función: %s\n', nombres{i});
    fprintf('Intervalo: [%.2f, %.2f]\n', a, b);
    fprintf('xmin = %.6f\n', xmin);
    fprintf('f(xmin) = %.6f\n', fmin);
    fprintf('Iteraciones = %d\n', iter);
    fprintf('Tiempo = %.6f s\n\n', tiempo);
end

% ---------------- MÉTODO DE NEWTON ----------------
fprintf('==============================\n');
fprintf('MÉTODO DE NEWTON\n');
fprintf('==============================\n\n');

% Para la realización de este método es necesario conocer las derivadas de
% las funciones. Debido a este motivo, no es posible realizarlo con la
% funcion numero 4.
df1 = @(x) 6*x.^5 - 21*x.^2;
ddf1= @(x) 30*x.^4 - 42*x;

df2 = @(x) 1./x - cos(x);
ddf2= @(x) -1./x.^2 + sin(x);

df3 = @(x) -exp(cos(x)).*sin(x) - 1;
ddf3= @(x) exp(cos(x)).*(sin(x).^2 - cos(x));

derivadas = {df1, df2, df3};
segundas  = {ddf1, ddf2, ddf3};

for i = 1:n

    % No aplicar a funcionrr
    if i == 4
        res_new(i,:) = [NaN, NaN, NaN, NaN];
        continue;
    end

    f = funciones{i};
    df  = derivadas{i};
    ddf = segundas{i};

    a = intervalos(i,1);
    b = intervalos(i,2);

    x0 = (a + b)/2; % Punto inicial

    [xmin, fmin, iter, tiempo] = new(f, df, ddf, x0, tol);
    res_new(i,:) = [xmin, fmin, iter, tiempo];

    fprintf('Función: %s\n', nombres{i});
    fprintf('Intervalo: [%.2f, %.2f]\n', a, b);
    fprintf('xmin = %.6f\n', xmin);
    fprintf('f(xmin) = %.6f\n', fmin);
    fprintf('Iteraciones = %d\n', iter);
    fprintf('Tiempo = %.6f s\n\n', tiempo);
end


%%
% ---------------------------------------------------------------------
% Bloque para ejecutar el metodo de Newton sobre una función numerica

f = funciones{4};

% Primera derivada
df = @(f, x, h) (f(x + h) - f(x - h)) / (2*h);

% Segunda derivada. Se ha evitado la opción de derivar la derivada para
% reducir los costes de su ejecución.
ddf = @(f, x, h) (f(x + h) - 2*f(x) + f(x - h)) / (h^2);

a = intervalos(4,1);
b = intervalos(4,2);
x0 = (a + b)/2; % Punto inicial

[xmin, fmin, iter, tiempo] = new_numerical(f, df, ddf, x0, tol);
res_new(4,:) = [xmin, fmin, iter, tiempo];

fprintf('Función: %s\n', nombres{i});
fprintf('Intervalo: [%.2f, %.2f]\n', a, b);
fprintf('xmin = %.6f\n', xmin);
fprintf('f(xmin) = %.6f\n', fmin);
fprintf('Iteraciones = %d\n', iter);
fprintf('Tiempo = %.6f s\n\n', tiempo);

% Fin del bloque
%------------------------------------------------------------------

%%
% ---------------- RECTAS INEXACTAS ----------------
fprintf('==============================\n');
fprintf('MÉTODO DE RECTAS INEXACTAS\n');
fprintf('==============================\n\n');

for i = 1:n
    f = funciones{i};
    a = intervalos(i,1);
    b = intervalos(i,2);

    [xmin, fmin, iter, tiempo] = rein(f, a, b, tol);

    res_rein(i,:) = [xmin, fmin, iter, tiempo];

    fprintf('Función: %s\n', nombres{i});
    fprintf('Intervalo: [%.2f, %.2f]\n', a, b);
    fprintf('xmin = %.6f\n', xmin);
    fprintf('f(xmin) = %.6f\n', fmin);
    fprintf('Iteraciones = %d\n', iter);
    fprintf('Tiempo = %.6f s\n\n', tiempo);
end

% ---------------- TABLAS FINALES ----------------
tabla_budi = array2table(res_budi, ...
    'VariableNames', {'xmin','fmin','iteraciones','tiempo'}, ...
    'RowNames', nombres);

disp('--- TABLA RESULTADOS BÚSQUEDA DICOTÓMICA ---');
disp(tabla_budi);



tabla_incu = array2table(res_incu, ...
    'VariableNames', {'xmin','fmin','iteraciones','tiempo'}, ...
    'RowNames', nombres);

disp('--- TABLA RESULTADOS INTERPOLACIÓN CUADRÁTICA ---');
disp(tabla_incu);



tabla_new = array2table(res_new, ...
    'VariableNames', {'xmin','fmin','iteraciones','tiempo'}, ...
    'RowNames', nombres);

disp('--- TABLA RESULTADOS MÉTODO DE NEWTON ---');
disp(tabla_new);



tabla_rein = array2table(res_rein, ...
    'VariableNames', {'xmin','fmin','iteraciones','tiempo'}, ...
    'RowNames', nombres);

disp('--- TABLA RESULTADOS RECTAS INEXACTAS ---');
disp(tabla_rein);