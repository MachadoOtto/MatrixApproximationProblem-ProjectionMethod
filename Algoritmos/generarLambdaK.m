#OBLIGATORIO 1 - Metodos Numericos 2021 - Grupo 63

#Funcion auxiliar generar lambda variando k.
function [lambda, k] = generarLambdaK()
  
  k = unifrnd(0,1);
  #Creamos la matriz diagonal lambda  
  lambda = zeros(6,6);
  lambda(1,1) = 3 - k; 
  lambda(2,2) = 1 + k; 
  for i = 3 : 6
    lambda(i,i) = -1;
  endfor
  
endfunction