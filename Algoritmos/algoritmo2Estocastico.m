#OBLIGATORIO 1 - Metodos Numericos 2021 - Grupo 63

#Algoritmo 2 modificado estocastico - Algoritmo (P1)*
function [Y, X, iter] = algoritmo2Estocastico(Y, lambda, maxIter, precision)
#Requiere: lambda = {lambda_1, ..., lambda_5} con condiciones de generarLambdaCompleja().
#Y in R^(5*5) no-negativa.

#Algoritmo de aproximacion.

iter = 0;
valorNorma = 0;
[n,m] = size(lambda);

X = Y;
do
  iter += 1;
  Y = maxZeta(X);
  [U, T] = schur(complex(Y), "complex");
  X = proyectPsi(U, T, lambda);
  valorNorma = norm(X - Y, "fro");
until((valorNorma < eps(1*(10^(16 - precision)))) || (iter > maxIter))

endfunction