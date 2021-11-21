#OBLIGATORIO 1 - Metodos Numericos 2021 - Grupo 63

#Funcion auxiliar maxCero para Algoritmo 1
function resultado = maxCero(resultado)
  #Dado una matriz A in Rn*m (o Cn*m) retorna la matriz A+
  
  [n, m] = size(resultado);
  for i = 1 :  n
    for j = 1 : m
      resultado(i,j) = max(0, real(resultado(i,j)));
    endfor
  endfor
  
endfunction