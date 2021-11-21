#OBLIGATORIO 1 - Metodos Numericos 2021 - Grupo 63

#Algoritmo 2 - Algoritmo para (P1)
function [Y, X, iter] = algoritmo2(Y, lambda, maxIter, precision)
#Requiere: lambda = {lambda_1, ..., lambda_n}
#Y in R^(n*n) no-negativa aleatoria.

#Algoritmo de aproximacion.
iter = 0;
valorNorma = 0;
[n,m] = size(lambda);

do
  iter += 1;
  [U, T] = schur(complex(Y), "complex");
  X = proyectPsi(U, T, lambda);
  Y = maxCero(X);
  valorNorma = norm(X - Y, "fro");
until((valorNorma < eps(1*(10^(16 - precision)))) || (iter > maxIter))

endfunction