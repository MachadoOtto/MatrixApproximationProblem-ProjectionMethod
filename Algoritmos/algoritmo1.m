#OBLIGATORIO 1 - Metodos Numericos 2021 - Grupo 63

#Algoritmo 1 - Algoritmo para (P2)
function [Y, X, iter] = algoritmo1(Y, lambda, maxIter, precision)
#Requiere: lambda = {lambda_1, ..., lambda_n},
#  con: lambda_1 >= ... >= lambda_n.

#Y in Gamma aleatorio.
# Gamma = {G o G: G in Rn*n, G = transpose(G)}
# G o H := G(i,j)*H(i,j), con i,j = 1 .. n y G,H in Rn*n

#Algoritmo de aproximacion.
iter = 0;
valorNorma = 0;
[n,m] = size(lambda);

do
  iter += 1;
  [V, mu] = eig(Y);
  X = V*lambda*transpose(V);
  X = (1/2)*(X + transpose(X));
  Y = maxCero(X);
  valorNorma = norm(X - Y, "fro");
until((valorNorma < eps(1*(10^(16 - precision)))) || (iter > maxIter))

endfunction