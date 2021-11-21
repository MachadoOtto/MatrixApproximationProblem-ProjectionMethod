#OBLIGATORIO 1 - Metodos Numericos 2021 - Grupo 63

function lambda = generarLambdaCompleja(n, a, b)
  #Ingrese el a,b: a<b, [a,b] es el rango de las entradas de la matriz
  
  #Creamos la matriz diagonal lambda  
  lambda = zeros(n,n);
  iter = 1;
  if (mod(n, 2) != 0)
    lambda(iter,iter) = unifrnd(a,b);
    iter += 1;
  endif
  while (iter <= n)
    complejo = unifrnd(a,b);
    real = unifrnd(a,b);
    lambda(iter,iter) = complex(real, complejo);
    iter += 1;
    lambda(iter,iter) = complex(real, -complejo);
    iter += 1;
  endwhile
  
endfunction