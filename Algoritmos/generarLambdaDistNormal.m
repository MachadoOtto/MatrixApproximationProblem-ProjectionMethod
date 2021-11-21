#OBLIGATORIO 1 - Metodos Numericos 2021 - Grupo 63

#Funcion auxiliar para generar lambda con una distribucion normal (dimension 5).
function lambda = generarLambdaDistNormal()
  
  #Creamos la matriz diagonal lambda  
  lambda = zeros(5,5);
  lambda(1,1) = 1;
  for i = 2 : 5
    valor = stdnormal_rnd(1);
    if (valor >= 0)
      lambda(i,i) = min(valor, 1);
    else
      lambda(i,i) = max(valor, -1);
    endif
  endfor
  
endfunction