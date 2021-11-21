#OBLIGATORIO 1 - Metodos Numericos 2021 - Grupo 63

#Funcion auxiliar proyectPsi para Algoritmo 2
#Dado una matriz unitaria U, una matriz triangular superior T cuya diagonal contiene
#  exactamente los autovalores Mu, tal que A = U*T*U^(-1) (descomposicion de Schur).
#  Retorna la matriz U*T'*U^(-1) con autovalores Lambda proyeccion de A dada en 3.1.1.
function resultado = proyectPsi(U, T, lambda)
  [n,m] = size(T);
  lambda_per = permutacion_minima(T, lambda);
  T_aux = T;
  for i = 1 : n
    T_aux(i,i) = lambda_per(i);
  endfor
  resultado = U*(T_aux)*(U^(-1));
endfunction