# Problema de Aproximación de Matrices mediante Proyecciones
## Jorge Machado Ottonelli - Métodos Numéricos - Facultad de Ingenieria UdelaR

Proyecto de la asignatura Métodos Numéricos, realizada con los compañeros:
 *      Cesar Agustin Cortondo Landache
 *      Jorge Miguel Machado Ottonelli
 *      Eber Manuel Rodríguez Gonzalez
 *      Jorge Daniel Perez Kranilovich

Proyecto para la asignatura Métodos Numéricos de la Facultad de Ingeniería (UdelaR). El mismo estudia la resolución de problemas de aproximación de matrices con ciertas condiciones mediante proyecciones en conjuntos, implementados mediante algoritmos iterativos.

Se recomienda la lectura del documento para comprender más acerca del problema y la resolución planteada.

## Manual de uso para los algoritmos presentados en el Proyecto.

### Para ejecutar todos los algoritmos solamente se utilizan y modifican dos archivos: main.m, y cargarDatos.m. Se recuerda que la implementación y ejecución del mismo fue realizada en *Octave*.

### MAIN.M :
Es el archivo principal que permite ejecutar todos los algoritmos que se utilizan en el Proyecto:

	1. algoritmo1.m (Problema P2)
	2. algoritmo2.m (Problema P1)
	3. algoritmo2Estocastico.m (Problema P1*)
	
En este script se permite el ingreso y modificación de la precisión del épsilon, dimensión de la matriz de entrada (salida), máximo de iteraciones y máximo de simulaciones a utilizar en cualquiera de estos algoritmos.

#### Atención: Tanto las soluciones como los datos iniciales son impresos en archivos .txt al finalizar una operación. En caso de querer realizar una operación mas de una vez, se recomienda reescribir el nombre del archivo ya que este se sobrescribe.

Los casos que se pueden ejecutar con main, son los siguientes:

	1. Problema (P2) - Manual: Permite la ejecución de un problema P2 utilizando los datos deseados, los cuales se deberán ingresar previamente en cargarDatos.m.
	2. Simulaciones (P2): Permite realizar 'maxSimulaciones' de problemas P2, en los cuales:
		* Los valores del lambda de entrada se fijan en el rango [min_l, max_l] (los cuales se pueden modificar al principio del main.m).
		* Los valores de la matriz de entrada se fijan en el rango [min_y, max_y] (los cuales se pueden modificar al principio del main.m) (Para cumplir la condición de no negatividad se recomienda dejar a min_y == 0).
	3. Problema (P1) - Manual: Permite la ejecución de un problema P1 utilizando los datos deseados, los cuales se deberan ingresar previamente en cargarDatos.m.
	4. Simulaciones (P1): Permite realizar 'maxSimulaciones' de problemas P1, en los cuales:
		* Los valores reales y imaginarios del lambda de entrada se fijan en el rango [min_l, max_l] (los cuales se pueden modificar al principio del main.m).
		* Los valores de la matriz de entrada se fijan en el rango [min_y, max_y] (los cuales se pueden modificar al principio del main.m) (Para cumplir la condición de no negatividad se recomienda dejar a min_y == 0).
	5. Simulaciones (P2) con lambda variando k: Permite realizar 'maxSimulaciones' de problemas P2 variando lambda con un valor k aleatorio (con distribución uniforme entre 0 y 1), en los cuales:
		* Los valores del lambda de entrada se generan siguiendo lo siguiente: lambda = [3 - k, 2 + k, -1, -1, -1, -1].
		* Los valores de la matriz de entrada se fijan en el rango [min_y, max_y] (los cuales se pueden modificar al principio del main.m) (Para cumplir la condición de no negatividad se recomienda dejar a min_y == 0).
	6. Problema (P1)* variación - Manual: Permite la ejecución de un problema P1* (caso estocástico) utilizando los datos deseados, los cuales se deberán ingresar previamente en cargarDatos.m. Se recomienda que el vector lambda cargado sea real y sus valores esten entre [-1, 1], con al menos una entrada igual a 1.
	7. Simulaciones variación estocástica de (P1)*: Permite realizar 'maxSimulaciones' de problemas P1* (casos estocásticos), en los cuales:
		*Los valores del lambda de entrada se fijan siguiendo una distribución normal [0,1] (estos valores siempre estarán en el intervalo [-1, 1]), y donde al menos una de sus entradas es igual a 1.
		*Los valores de la matriz de entrada se fijan en el rango [min_y, max_y] (los cuales se pueden modificar al principio del main.m) (Para cumplir la condición de no negatividad se recomienda dejar a min_y == 0).

### CARGARDATOS.M : 
Aquí se realiza la carga de los datos para pruebas "Manuales". Para ingresarlos se deberán de copiar en 'Y' y en 'lambda' las matrices y vectores correspondientes a cargar. Notar que 'lambda' debe ser escrito siguiendo este formato 'lambda = diag([lambda_1, ..., lambda_n])':

*	Para las pruebas en P1 y P2 se deberá sobrescribir el campo de 'Y' (línea 9 del archivo) y 'lambda' (línea 10 del archivo).
*	Para las pruebas de P1* (caso estocástico) se deberá sobrescribir el campo de 'Y_e' (línea 13 del archivo) y 'lambda_e' (línea 14 del archivo). Recordar que estos deberán tener dimensión 5 para cumplir la hipótesis del problema (forma de Z).
