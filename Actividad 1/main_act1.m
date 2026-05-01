clc; clear; close all;

% ---------------- PARÁMETROS GENERALES ----------------

tol = 1e-5;
delta = 1e-4;

% -------------- DEFINICIÓN DE FUNCIONES ----------------

f1 = @(x) x.^6 - 7*x.^3 + 7;
f2 = @(x) log(x) - sin(x);
f3 = @(x) exp(cos(x)) - x;
f4 = @funcionrr;

% ------------ DIBUJO DE LA CUARTA FUNCIÓN -------------

x = linspace(1,4,50);
y = arrayfun(f4, x);

plot(x,y)
grid on
title('Funcion numérica en [1,4]')