#OBLIGATORIO 1 - Metodos Numericos 2021 - Grupo 63

#Funcion auxiliar maxZeta para Algoritmo 2 Estocastico
#Retorna una matriz 6x6 no-negativa con la forma de Z.
function resultado = maxZeta(resultado)
  
  resultado = maxCero(resultado);
  resultado(1,3) = 0;
  resultado(1,4) = 0;
  resultado(2,4) = 0;
  resultado(2,5) = 0;
  resultado(3,1) = 0;
  resultado(3,5) = 0;
  resultado(4,1) = 0;
  resultado(4,2) = 0;
  resultado(5,2) = 0;
  resultado(5,3) = 0;
  for i = 1 : 5
    sumaFila = sum(resultado(i,:));
    for j = 1 : 5
      resultado(i,j) = resultado(i,j)/sumaFila;
    endfor
  endfor 
  
endfunction