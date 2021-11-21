#OBLIGATORIO 1 - Metodos Numericos 2021 - Grupo 63

function lambda = generarLambda(n,a,b)
  #Ingrese el a,b: a<b, [a,b] es el rango de las entradas de la matriz.
  
  #Creamos la matriz diagonal lambda  
  lambda = zeros(n,n);
  for i = 1 : n
    lambda(i,i) = unifrnd(a,b);
  endfor
  
endfunction