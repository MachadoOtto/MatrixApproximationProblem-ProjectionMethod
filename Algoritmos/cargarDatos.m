#OBLIGATORIO 1 - Metodos Numericos 2021 - Grupo 63

#Funcion para cargar los datos manualmente:

#Copiar en Y y en lambda los datos correspondientes a cargar.
#lambda debe ser escrito de la siguiente manera = diag([lambda_1, ..., lambda_n]).
function [Y, lambda, Y_e, lambda_e] = cargarDatos()
  #Datos para pruebas manuales en (P2) y (P1).
  Y = [];
  lambda = diag([]);  
  #Datos para pruebas manuales en la modificacion estocastica de (P1)*.
  %ATENCION: La dimension debe ser 5.
  Y_e = [];
  lambda_e = diag([]);
endfunction

#Valores especiales:

%Y 3x3 con lambdas complejos:
% [0,2,0; 0,0,3; 4,5,0];