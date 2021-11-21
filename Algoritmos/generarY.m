#OBLIGATORIO 1 - Metodos Numericos 2021 - Grupo 63

function res = generarY(n, esSimetrica, a, b)
  #Ingrese el a,b: a<b, [a,b] es el rango de las entradas de la matriz Y
  
  #Creamos la matriz no negativa de manera generica
  res = unifrnd(a,b,n,n);
  if (esSimetrica)
    res = (1/2)*(res + transpose(res));
  endif
  
endfunction