#OBLIGATORIO 1 - Metodos Numericos 2021 - Grupo 63

#Retorna la permutacion minima de lambda con T, es permutacion minima si:
# el vector cumple minizar \sum |lambda_i T_ii|^2
function lambda_res = permutacion_minima(T, lambda)
  [n,m] = size(lambda);
  lambda_per = perms(diag(lambda));
  lambda_res = [];
  tam_minimo = -1;
  for (i = 1 : factorial(n))
    tamanio = 0;
    for (j = 1 : n)
      tamanio += abs(lambda_per(i,j) - T(j,j))^2;    
    endfor
    if ((tamanio < tam_minimo) || (tam_minimo == -1))
      tam_minimo = tamanio;
      lambda_res = lambda_per(i,:);
    endif
  endfor
endfunction