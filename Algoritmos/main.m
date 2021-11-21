#OBLIGATORIO 1 - METODOS NUMERICOS - GRUPO 63

###---ATENCION: Se recomienda hacer 'clear' antes de ejecutar main.---###
#Script main de las funciones algoritmo1 y algoritmo2.

#Definicion de packages:
pkg load statistics;
barra = '#------------------------------------------#';

#Modificar solamente los siguientes casos del script:
precision = 10; %Precision mostrada por el sistema (1*10^-precision).
dimension = 45; %Dimension de las matrices.
maxIter = 1000; %Maximo iteraciones por algoritmo.
maxSimulaciones = 100; %Se utiliza solamente al seleccionar Simulaciones.
min_l = -10; %Minimo valor que puede tomar lambda.
max_l = 10; %Maximo valor que puede tomar lambda.
min_y = 0; %Minimo valor que puede tomar Y.
max_y = 10; %Maximo valor que puede tomar Y.
#Solamente para casos manuales:
[Y, lambda, Y_e, lambda_e] = cargarDatos(); %Modificar los datos a cargar en la funcion cargarDatos.

#Seleccion de operacion a ejecutar.
opcion = menu("Ejecutar operaciones:", "Problema (P2) - Manual", 
  "Simulaciones (P2)", "Problema (P1) - Manual", "Simulaciones (P1)", 
  "Simulaciones (P2) con lambda variando k (dimension 6)", "Problema (P1)* variacion - Manual", 
  "Simulaciones variacion estocastica de (P1)* (dimension 5)");

switch (opcion)
  #---Algoritmo 1---
  
  case 1 #Caso concreto de (P2) - se carga en cargarDatos.m.
    #Y = generarY(dimension, true, min_y, max_y); %En caso de querer usar Y generica descomentar.
    display('Comienza ejecucion de P2');
    lambda = diag(sort(lambda)); #Reordenar lambda.
    
    temp = tic(); #Comienza algoritmo 1.
    [Y_res, X_res, iter_a] = algoritmo1(Y, lambda, maxIter, precision);
    tiempo = toc(temp); #Finaliza algoritmo 1.
    
    [V_y, lambda_res] = eig(Y_res);
    lambda = diag(lambda);
    norma_res = norm(X_res - Y_res, "fro");
    if (norma_res < eps(1*(10^(16 - precision)))) #Cumple convergencia a epsilon.
      display(strcat('!!! Convergencia:', num2str(norma_res)));
      
    endif
    #Se genera el archivo de carga manual .txt.  
    texto = '#Resultados de la carga manual de P2.';
    display(texto);
    dlmwrite('resultadosManualP2.txt',texto,'delimiter','');
    dlmwrite('resultadosManualP2.txt',barra,'-append','delimiter','');
    texto = strcat('-Precision:eps(10^-', num2str(precision),')');
    display(texto);
    dlmwrite('resultadosManualP2.txt',texto,'-append','delimiter','');
    texto = strcat('-Dimension:', num2str(dimension));
    display(texto);
    dlmwrite('resultadosManualP2.txt',texto,'-append','delimiter','');
    texto = strcat('-Maximo de Iteraciones:', num2str(maxIter));
    display(texto);
    dlmwrite('resultadosManualP2.txt',texto,'-append','delimiter','');
    dlmwrite('resultadosManualP2.txt',barra,'-append','delimiter','');
    texto = '---Datos Iniciales---';
    display(texto);
    dlmwrite('resultadosManualP2.txt',texto,'-append','delimiter','');
    display(lambda);
    save -append resultadosManualP2.txt lambda;
    display(Y);
    save -append resultadosManualP2.txt Y;
    texto = '---Resultados---';
    display(texto);
    dlmwrite('resultadosManualP2.txt',texto,'-append','delimiter','');
    texto = strcat('-Norma resultado:', num2str(norma_res));
    display(texto);
    display(lambda_res);
    save -append resultadosManualP2.txt lambda_res;
    display(Y_res);
    save -append resultadosManualP2.txt Y_res;
    dlmwrite('resultadosManualP2.txt',barra,'-append','delimiter','');
    texto = strcat('Tiempo total de la ejecucion (en segundos):', num2str(tiempo));
    display(texto);
    dlmwrite('resultadosManualP2.txt',texto,'-append','delimiter','');
    texto = strcat('Total de iteraciones:', num2str(iter_a));
    display(texto);
    dlmwrite('resultadosManualP2.txt',texto,'-append','delimiter','');
    
  case 2 #Simulaciones de (P2) de 'n' dimension. 
    #Se genera el archivo de simulacion .txt.  
    texto = '#Resultados de la simulacion de P2.';
    dlmwrite('simulacionP2.txt',texto,'delimiter','');
    dlmwrite('simulacionP2.txt',barra,'-append','delimiter','');
    texto = strcat('-Precision:eps(10^-', num2str(precision),')');
    dlmwrite('simulacionP2.txt',texto,'-append','delimiter','');
    texto = strcat('-Dimension:', num2str(dimension));
    dlmwrite('simulacionP2.txt',texto,'-append','delimiter','');
    texto = strcat('-Maximo de Iteraciones:', num2str(maxIter));
    dlmwrite('simulacionP2.txt',texto,'-append','delimiter','');
    texto = strcat('-Maximo de Simulaciones:', num2str(maxSimulaciones));
    dlmwrite('simulacionP2.txt',texto,'-append','delimiter','');
    #Vector con soluciones que cumplen convergencia a epsilon.
    sol_convergentes = [];
    #Vectores con tiempo y cantidad de iteraciones de cada simulacion.
    t_sim = [];
    iter_sim = [];
    #Comienza la simulacion. Se registra el tiempo en total y por simulacion.
    display('Comienza simulacion de P2');
    t_general = tic(); #Comienza simulaciones.
    for (i = 1 : maxSimulaciones)
      display(strcat('Progreso:', num2str(i), '/', num2str(maxSimulaciones)));
      #Generacion de lambda e Y.
      lambda = generarLambda(dimension, min_l, max_l);
      lambda = diag(sort(diag(lambda))); #Reordenar lambda.
      Y = generarY(dimension, true, min_y, max_y); #Y simetrica.
      
      temp = tic(); #Comienza algoritmo 1.
      [Y_res, X_res, iter_a] = algoritmo1(Y, lambda, maxIter, precision);
      tiempo = toc(temp); #Finaliza algoritmo 1.
      
      [V_y, lambda_res] = eig(Y_res);
      lambda = diag(lambda);
      norma_res = norm(X_res - Y_res, "fro");
      if (norma_res < eps(1*(10^(16 - precision)))) #Cumple convergencia a epsilon.
        sol_convergentes = [sol_convergentes, i];
        t_sim = [t_sim, tiempo];
        iter_sim = [iter_sim, iter_a];
        display(strcat('!!! Convergencia:', num2str(norma_res)));
      endif
      #Registro en .txt.
      dlmwrite('simulacionP2.txt',barra,'-append','delimiter','');
      texto = strcat('-Simulacion N.', num2str(i));
      dlmwrite('simulacionP2.txt',texto,'-append','delimiter','');
      texto = strcat('Total de iteraciones:', num2str(iter_a));
      dlmwrite('simulacionP2.txt',texto,'-append','delimiter','');
      texto = strcat('Tiempo de ejecucion:', num2str(tiempo));
      dlmwrite('simulacionP2.txt',texto,'-append','delimiter','');
      texto = '---Datos Iniciales---';
      dlmwrite('simulacionP2.txt',texto,'-append','delimiter','');
      save -append simulacionP2.txt lambda;
      save -append simulacionP2.txt Y;
      texto = '---Resultados---';
      dlmwrite('simulacionP2.txt',texto,'-append','delimiter','');
      texto = strcat('-Norma resultado:', num2str(norma_res));
      dlmwrite('simulacionP2.txt',texto,'-append','delimiter','');
      save -append simulacionP2.txt lambda_res;
      save -append simulacionP2.txt Y_res;
    endfor
    tiempo_total = toc(t_general); #Finaliza simulaciones.
    dlmwrite('simulacionP2.txt',barra,'-append','delimiter','');
    texto = strcat('#Cantidad de convergencias:', num2str(size(sol_convergentes)));
    display(texto);
    dlmwrite('simulacionP2.txt',texto,'-append','delimiter','');
    texto = '#Simulaciones convergentes:';
    dlmwrite('simulacionP2.txt',texto,'-append','delimiter','');
    dlmwrite('simulacionP2.txt',sol_convergentes,'-append','delimiter',' , ')
    texto = strcat('Tiempo total de la simulacion (en segundos):', num2str(tiempo_total));
    dlmwrite('simulacionP2.txt',texto,'-append','delimiter','');
    texto = strcat('Tiempo promedio por simulacion exitosa (en segundos):', num2str(mean(t_sim)));
    dlmwrite('simulacionP2.txt',texto,'-append','delimiter','');
    display('La Simulacion ha finalizado');
    display(strcat('Tiempo total de la simulacion (en minutos):', num2str(tiempo_total/60)));
    texto = strcat('Media de iteraciones con exito:', num2str(mean(iter_sim)));
    dlmwrite('simulacionP2.txt',texto,'-append','delimiter','');
    texto = strcat('Total de iteraciones:', num2str(sum(iter_sim)));
    display(texto);
    dlmwrite('simulacionP2.txt',texto,'-append','delimiter','');
    
  #---Algoritmo 2---
  
  case 3 #Caso concreto de (P1) - se carga en cargarDatos.m.
    #Y = generarY(dimension, false, min_y, max_y); %En caso de querer usar Y generica descomentar.
    display('Comienza ejecucion de P1');
    
    temp = tic(); #Comienza algoritmo 2.
    [Y_res, X_res, iter_a] = algoritmo2(Y, lambda, maxIter, precision);
    tiempo = toc(temp); #Finaliza algoritmo 2.
    
    [U_res, T_res] = schur(Y_res, "complex");
    lambda = diag(lambda);
    lambda_res = diag(T_res);
    norma_res = norm(X_res - Y_res, "fro");
    if (norma_res < eps(1*(10^(16 - precision)))) #Cumple convergencia a epsilon.
      display(strcat('!!! Convergencia:', num2str(norma_res)));
    endif
    #Se genera el archivo de carga manual .txt.  
    texto = '#Resultados de la carga manual de P1.';
    display(texto);
    dlmwrite('resultadosManualP1.txt',texto,'delimiter','');
    dlmwrite('resultadosManualP1.txt',barra,'-append','delimiter','');
    texto = strcat('-Precision:eps(10^-', num2str(precision),')');
    display(texto);
    dlmwrite('resultadosManualP1.txt',texto,'-append','delimiter','');
    texto = strcat('-Dimension:', num2str(dimension));
    display(texto);
    dlmwrite('resultadosManualP1.txt',texto,'-append','delimiter','');
    texto = strcat('-Maximo de Iteraciones:', num2str(maxIter));
    display(texto);
    dlmwrite('resultadosManualP1.txt',texto,'-append','delimiter','');
    dlmwrite('resultadosManualP1.txt',barra,'-append','delimiter','');
    texto = '---Datos Iniciales---';
    display(texto);
    dlmwrite('resultadosManualP1.txt',texto,'-append','delimiter','');
    display(lambda);
    save -append resultadosManualP1.txt lambda;
    display(Y);
    save -append resultadosManualP1.txt Y;
    texto = '---Resultados---';
    display(texto);
    dlmwrite('resultadosManualP1.txt',texto,'-append','delimiter','');
    texto = strcat('-Norma resultado:', num2str(norma_res));
    display(texto);
    display(lambda_res);
    save -append resultadosManualP1.txt lambda_res;
    display(Y_res);
    save -append resultadosManualP1.txt Y_res;
    dlmwrite('resultadosManualP1.txt',barra,'-append','delimiter','');
    texto = strcat('Tiempo total de la ejecucion (en segundos):', num2str(tiempo));
    display(texto);
    dlmwrite('resultadosManualP1.txt',texto,'-append','delimiter','');
    texto = strcat('Total de iteraciones:', num2str(iter_a));
    display(texto);
    dlmwrite('resultadosManualP1.txt',texto,'-append','delimiter','');
  
  case 4 #Simulaciones de (P1) de 'n' dimension.
    #Se genera el archivo de simulacion .txt.  
    texto = '#Resultados de la simulacion de P1.';
    dlmwrite('simulacionP1.txt',texto,'delimiter','');
    dlmwrite('simulacionP1.txt',barra,'-append','delimiter','');
    texto = strcat('-Precision:eps(10^-', num2str(precision),')');
    dlmwrite('simulacionP1.txt',texto,'-append','delimiter','');
    texto = strcat('-Dimension:', num2str(dimension));
    dlmwrite('simulacionP1.txt',texto,'-append','delimiter','');
    texto = strcat('-Maximo de Iteraciones:', num2str(maxIter));
    dlmwrite('simulacionP1.txt',texto,'-append','delimiter','');
    texto = strcat('-Maximo de Simulaciones:', num2str(maxSimulaciones));
    dlmwrite('simulacionP1.txt',texto,'-append','delimiter','');
    #Vector con soluciones que cumplen convergencia a epsilon.
    sol_convergentes = [];
    #Vector con tiempo y cantidad de iteraciones de cada simulacion.
    t_sim = [];
    iter_sim = [];
    #Comienza la simulacion. Se registra el tiempo en total y por simulacion.
    display('Comienza simulacion de P1');
    t_general = tic(); #Comienza simulaciones.
    for (i = 1 : maxSimulaciones)
      display(strcat('Progreso:', num2str(i), '/', num2str(maxSimulaciones)));
      #Generacion de lambda e Y.
      lambda = generarLambdaCompleja(dimension, min_l, max_l);
      Y = generarY(dimension, false, min_y, max_y);
      
      temp = tic(); #Comienza algoritmo 2.
      [Y_res, X_res, iter_a] = algoritmo2(Y, lambda, maxIter, precision);
      tiempo = toc(temp); #Finaliza algoritmo 2.
      
      [U_res, T_res] = schur(Y_res, "complex");
      lambda = diag(lambda);
      lambda_res = diag(T_res);
      norma_res = norm(X_res - Y_res, "fro");
      if (norma_res < eps(1*(10^(16 - precision)))) #Cumple convergencia a epsilon.
        sol_convergentes = [sol_convergentes, i];
        iter_sim = [iter_sim, iter_a];
        t_sim = [t_sim, tiempo];
        display(strcat('!!! Convergencia:', num2str(norma_res)));
      endif
      #Registro en .txt.
      dlmwrite('simulacionP1.txt',barra,'-append','delimiter','');
      texto = strcat('-Simulacion N.', num2str(i));
      dlmwrite('simulacionP1.txt',texto,'-append','delimiter','');
      texto = strcat('Total de iteraciones:', num2str(iter_a));
      dlmwrite('simulacionP1.txt',texto,'-append','delimiter','');
      texto = strcat('Tiempo de ejecucion:', num2str(tiempo));
      dlmwrite('simulacionP1.txt',texto,'-append','delimiter','');
      texto = '---Datos Iniciales---';
      dlmwrite('simulacionP1.txt',texto,'-append','delimiter','');
      save -append simulacionP1.txt lambda;
      save -append simulacionP1.txt Y;
      texto = '---Resultados---';
      dlmwrite('simulacionP1.txt',texto,'-append','delimiter','');
      texto = strcat('-Norma resultado:', num2str(norma_res));
      dlmwrite('simulacionP1.txt',texto,'-append','delimiter','');
      save -append simulacionP1.txt lambda_res;
      save -append simulacionP1.txt Y_res;
    endfor
    tiempo_total = toc(t_general); #Finaliza simulaciones.
    dlmwrite('simulacionP1.txt',barra,'-append','delimiter','');
    texto = strcat('#Cantidad de convergencias:', num2str(size(sol_convergentes)));
    display(texto);
    dlmwrite('simulacionP1.txt',texto,'-append','delimiter','');
    texto = '#Simulaciones convergentes:';
    dlmwrite('simulacionP1.txt',texto,'-append','delimiter','');
    dlmwrite('simulacionP1.txt',sol_convergentes,'-append','delimiter',' , ')
    texto = strcat('Tiempo total de la simulacion (en segundos):', num2str(tiempo_total));
    dlmwrite('simulacionP1.txt',texto,'-append','delimiter','');
    texto = strcat('Tiempo promedio por simulacion exitosa (en segundos):', num2str(mean(t_sim)));
    dlmwrite('simulacionP1.txt',texto,'-append','delimiter','');
    display('La Simulacion ha finalizado');
    display(strcat('Tiempo total de la simulacion (en minutos):', num2str(tiempo_total/60)));
    texto = strcat('Media de iteraciones con exito:', num2str(mean(iter_sim)));
    dlmwrite('simulacionP1.txt',texto,'-append','delimiter','');
    texto = strcat('Total de iteraciones:', num2str(sum(iter_sim)));
    display(texto);
    dlmwrite('simulacionP1.txt',texto,'-append','delimiter','');
    
    case 5 #Simulaciones de (P2) con lambda dimension 6 variando k. 
    #Se genera el archivo de simulacion .txt.  
    texto = '#Resultados de la simulacion de P2.';
    dlmwrite('simulacionP2_K.txt',texto,'delimiter','');
    dlmwrite('simulacionP2_K.txt',barra,'-append','delimiter','');
    texto = strcat('-Precision:eps(10^-', num2str(precision),')');
    dlmwrite('simulacionP2_K.txt',texto,'-append','delimiter','');
    texto = strcat('-Dimension:', num2str(dimension));
    dlmwrite('simulacionP2_K.txt',texto,'-append','delimiter','');
    texto = strcat('-Maximo de Iteraciones:', num2str(maxIter));
    dlmwrite('simulacionP2_K.txt',texto,'-append','delimiter','');
    texto = strcat('-Maximo de Simulaciones:', num2str(maxSimulaciones));
    dlmwrite('simulacionP2_K.txt',texto,'-append','delimiter','');
    #Generacion de lambda variando k.
    [lambda, k] = generarLambdaK();
    lambda = diag(sort(diag(lambda))); #Reordenar lambda.
    texto = strcat('-Valor de k:', num2str(k));
    display(texto);
    dlmwrite('simulacionP2_K.txt',texto,'-append','delimiter','');
    save -append simulacionP2_K.txt lambda;
    #Vector con soluciones que cumplen convergencia a epsilon.
    sol_convergentes = [];
    #Vectores con tiempo y cantidad de iteraciones de cada simulacion.
    t_sim = [];
    iter_sim = [];
    #Comienza la simulacion. Se registra el tiempo en total y por simulacion.
    display('Comienza simulacion de P2');
    t_general = tic(); #Comienza simulaciones.
    for (i = 1 : maxSimulaciones)
      display(strcat('Progreso:', num2str(i), '/', num2str(maxSimulaciones)));
      #Generacion de Y.
      Y = generarY(6, true, min_y, max_y); #Y simetrica.
      
      temp = tic(); #Comienza algoritmo 1.
      [Y_res, X_res, iter_a] = algoritmo1(Y, lambda, maxIter, precision);
      tiempo = toc(temp); #Finaliza algoritmo 1.
      
      [V_y, lambda_res] = eig(Y_res);
      norma_res = norm(X_res - Y_res, "fro");
      if (norma_res < eps(1*(10^(16 - precision)))) #Cumple convergencia a epsilon.
        t_sim = [t_sim, tiempo];
        iter_sim = [iter_sim, iter_a];
        sol_convergentes = [sol_convergentes, i];
        display(strcat('!!! Convergencia:', num2str(norma_res)));
      endif
      #Registro en .txt.
      dlmwrite('simulacionP2_K.txt',barra,'-append','delimiter','');
      texto = strcat('-Simulacion N.', num2str(i));
      dlmwrite('simulacionP2_K.txt',texto,'-append','delimiter','');
      texto = strcat('Total de iteraciones:', num2str(iter_a));
      dlmwrite('simulacionP2_K.txt',texto,'-append','delimiter','');
      texto = strcat('Tiempo de ejecucion:', num2str(tiempo));
      dlmwrite('simulacionP2_K.txt',texto,'-append','delimiter','');
      texto = '---Datos Iniciales---';
      dlmwrite('simulacionP2_K.txt',texto,'-append','delimiter','');
      save -append simulacionP2_K.txt Y;
      texto = '---Resultados---';
      dlmwrite('simulacionP2_K.txt',texto,'-append','delimiter','');
      texto = strcat('-Norma resultado:', num2str(norma_res));
      dlmwrite('simulacionP2_K.txt',texto,'-append','delimiter','');
      save -append simulacionP2_K.txt lambda_res;
      save -append simulacionP2_K.txt Y_res;
    endfor
    tiempo_total = toc(t_general); #Finaliza simulaciones.
    dlmwrite('simulacionP2_K.txt',barra,'-append','delimiter','');
    texto = strcat('#Cantidad de convergencias:', num2str(size(sol_convergentes)));
    display(texto);
    dlmwrite('simulacionP2_K.txt',texto,'-append','delimiter','');
    texto = '#Simulaciones convergentes:';
    dlmwrite('simulacionP2_K.txt',texto,'-append','delimiter','');
    dlmwrite('simulacionP2_K.txt',sol_convergentes,'-append','delimiter',' , ')
    texto = strcat('Tiempo total de la simulacion (en segundos):', num2str(tiempo_total));
    dlmwrite('simulacionP2_K.txt',texto,'-append','delimiter','');
    texto = strcat('Tiempo promedio por simulacion exitosa (en segundos):', num2str(mean(t_sim)));
    dlmwrite('simulacionP2_K.txt',texto,'-append','delimiter','');
    display('La Simulacion ha finalizado');
    display(strcat('Tiempo total de la simulacion (en minutos):', num2str(tiempo_total/60)));
    texto = strcat('Media de iteraciones con exito:', num2str(mean(iter_sim)));
    dlmwrite('simulacionP2_K.txt',texto,'-append','delimiter','');
    texto = strcat('Total de iteraciones:', num2str(sum(iter_sim)));
    display(texto);
    dlmwrite('simulacionP2_K.txt',texto,'-append','delimiter','');
    
    case 6 #Caso concreto de (P1)* variacion - se carga en cargarDatos.m.
    #Y = generarY(dimension, false, min_y, max_y); %En caso de querer usar Y generica descomentar.
    display('Comienza ejecucion de P1* variacion');
    
    temp = tic(); #Comienza algoritmo 2 estocastico.
    [Y_res, X_res, iter_a] = algoritmo2Estocastico(Y_e, lambda_e, maxIter, precision);
    tiempo = toc(temp); #Finaliza algoritmo 2 estocastico.
    
    [U_res, T_res] = schur(Y_res, "complex");
    lambda = diag(lambda);
    lambda_res = diag(T_res);
    norma_res = norm(X_res - Y_res, "fro");
    if (norma_res < eps(1*(10^(16 - precision)))) #Cumple convergencia a epsilon.
      display(strcat('!!! Convergencia:', num2str(norma_res)));
    endif
    #Se genera el archivo de carga manual .txt.  
    texto = '#Resultados de la carga manual de P1* variacion.';
    display(texto);
    dlmwrite('resultadosManualP1VEstocastico.txt',texto,'delimiter','');
    dlmwrite('resultadosManualP1VEstocastico.txt',barra,'-append','delimiter','');
    texto = strcat('-Precision:eps(10^-', num2str(precision),')');
    display(texto);
    dlmwrite('resultadosManualP1VEstocastico.txt',texto,'-append','delimiter','');
    texto = strcat('-Dimension:', num2str(dimension));
    display(texto);
    dlmwrite('resultadosManualP1VEstocastico.txt',texto,'-append','delimiter','');
    texto = strcat('-Maximo de Iteraciones:', num2str(maxIter));
    display(texto);
    dlmwrite('resultadosManualP1VEstocastico.txt',texto,'-append','delimiter','');
    dlmwrite('resultadosManualP1VEstocastico.txt',barra,'-append','delimiter','');
    texto = '---Datos Iniciales---';
    display(texto);
    dlmwrite('resultadosManualP1VEstocastico.txt',texto,'-append','delimiter','');
    display(lambda);
    save -append resultadosManualP1VEstocastico.txt lambda;
    display(Y);
    save -append resultadosManualP1VEstocastico.txt Y;
    texto = '---Resultados---';
    display(texto);
    dlmwrite('resultadosManualP1VEstocastico.txt',texto,'-append','delimiter','');
    texto = strcat('-Norma resultado:', num2str(norma_res));
    display(texto);
    display(lambda_res);
    save -append resultadosManualP1VEstocastico.txt lambda_res;
    display(Y_res);
    save -append resultadosManualP1VEstocastico.txt Y_res;
    dlmwrite('resultadosManualP1VEstocastico.txt',barra,'-append','delimiter','');
    texto = strcat('Tiempo total de la ejecucion (en segundos):', num2str(tiempo));
    display(texto);
    dlmwrite('resultadosManualP1VEstocastico.txt',texto,'-append','delimiter','');
    texto = strcat('Total de iteraciones:', num2str(iter_a));
    display(texto);
    dlmwrite('resultadosManualP1VEstocastico.txt',texto,'-append','delimiter','');
    
    case 7 #Simulaciones variacion estocastica de (P1)* (dimension 5).
    #Se genera el archivo de simulacion .txt.  
    texto = '#Resultados de la simulacion estocastica de P1* modificado.';
    dlmwrite('simulacionP1Estocastica.txt',texto,'delimiter','');
    dlmwrite('simulacionP1Estocastica.txt',barra,'-append','delimiter','');
    texto = strcat('-Precision:eps(10^-', num2str(precision),')');
    dlmwrite('simulacionP1Estocastica.txt',texto,'-append','delimiter','');
    texto = strcat('-Dimension:5');
    dlmwrite('simulacionP1Estocastica.txt',texto,'-append','delimiter','');
    texto = strcat('-Maximo de Iteraciones:', num2str(maxIter));
    dlmwrite('simulacionP1Estocastica.txt',texto,'-append','delimiter','');
    texto = strcat('-Maximo de Simulaciones:', num2str(maxSimulaciones));
    dlmwrite('simulacionP1Estocastica.txt',texto,'-append','delimiter','');
    #Vector con soluciones que cumplen convergencia a epsilon.
    sol_convergentes = [];
    #Vector con tiempo y cantidad de iteraciones de cada simulacion.
    t_sim = [];
    iter_sim = [];
    #Comienza la simulacion. Se registra el tiempo en total y por simulacion.
    display('Comienza simulacion de P1*');
    t_general = tic(); #Comienza simulaciones.
    for (i = 1 : maxSimulaciones)
      display(strcat('Progreso:', num2str(i), '/', num2str(maxSimulaciones)));
      #Generacion de lambda e Y.
      lambda = generarLambdaDistNormal();
      Y = generarY(5, false, min_y, max_y);
      
      temp = tic(); #Comienza algoritmo 2.
      [Y_res, X_res, iter_a] = algoritmo2Estocastico(Y, lambda, maxIter, precision);
      tiempo = toc(temp); #Finaliza algoritmo 2.
      
      [V, lambda_res] = eig(Y_res);
      lambda = diag(lambda);
      norma_res = norm(X_res - Y_res, "fro");
      if (norma_res < eps(1*(10^(16 - precision)))) #Cumple convergencia a epsilon.
        sol_convergentes = [sol_convergentes, i];
        iter_sim = [iter_sim, iter_a];
        t_sim = [t_sim, tiempo];
        display(strcat('!!! Convergencia:', num2str(norma_res)));
      endif
      
      #Registro en .txt.
      dlmwrite('simulacionP1Estocastica.txt',barra,'-append','delimiter','');
      texto = strcat('-Simulacion N.', num2str(i));
      dlmwrite('simulacionP1Estocastica.txt',texto,'-append','delimiter','');
      texto = strcat('Total de iteraciones:', num2str(iter_a));
      dlmwrite('simulacionP1Estocastica.txt',texto,'-append','delimiter','');
      texto = strcat('Tiempo de ejecucion:', num2str(tiempo));
      dlmwrite('simulacionP1Estocastica.txt',texto,'-append','delimiter','');
      texto = '---Datos Iniciales---';
      dlmwrite('simulacionP1Estocastica.txt',texto,'-append','delimiter','');
      save -append simulacionP1Estocastica.txt lambda;
      save -append simulacionP1Estocastica.txt Y;
      texto = '---Resultados---';
      dlmwrite('simulacionP1Estocastica.txt',texto,'-append','delimiter','');
      texto = strcat('-Norma resultado:', num2str(norma_res));
      dlmwrite('simulacionP1Estocastica.txt',texto,'-append','delimiter','');
      save -append simulacionP1Estocastica.txt lambda_res;
      save -append simulacionP1Estocastica.txt Y_res;
    endfor
    tiempo_total = toc(t_general); #Finaliza simulaciones.
    dlmwrite('simulacionP1Estocastica.txt',barra,'-append','delimiter','');
    texto = strcat('#Cantidad de convergencias:', num2str(size(sol_convergentes)));
    display(texto);
    dlmwrite('simulacionP1Estocastica.txt',texto,'-append','delimiter','');
    texto = '#Simulaciones convergentes:';
    dlmwrite('simulacionP1Estocastica.txt',texto,'-append','delimiter','');
    dlmwrite('simulacionP1Estocastica.txt',sol_convergentes,'-append','delimiter',' , ')
    texto = strcat('Tiempo total de la simulacion (en segundos):', num2str(tiempo_total));
    dlmwrite('simulacionP1Estocastica.txt',texto,'-append','delimiter','');
    texto = strcat('Tiempo promedio por simulacion exitosa (en segundos):', num2str(mean(t_sim)));
    dlmwrite('simulacionP1Estocastica.txt',texto,'-append','delimiter','');
    display('La Simulacion ha finalizado');
    display(strcat('Tiempo total de la simulacion (en minutos):', num2str(tiempo_total/60)));
    texto = strcat('Media de iteraciones con exito:', num2str(mean(iter_sim)));
    dlmwrite('simulacionP1Estocastica.txt',texto,'-append','delimiter','');
    texto = strcat('Total de iteraciones:', num2str(sum(iter_sim)));
    display(texto);
    dlmwrite('simulacionP1Estocastica.txt',texto,'-append','delimiter','');
    
  otherwise
    
endswitch