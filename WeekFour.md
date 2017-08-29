# Regresión regularizada

1) Ajustar un modelo de regresión
2) Penalizar (o encojer) grandes coeficientes

Pros:

* Puede ayudar con el intercambio entre sesgo y varianza
* Puede ayudar con la selección del modelo

Contra:

* Puede ser computacionalmente demandante en grandes conjuntos de datos
* No tiene buen rendimiento comparado con Random Forest y Boosting

Si dos variables son co-lineares, es decir, casi la misma variable, 
entonces podemos aproximar  modelo lineal sumando los coeficientes de 
las dos variables y multiplicandola por una sola.

El resultado es:

* Obtendras una buena estimativa de Y
* La estimativa (de Y) será sesgada
* Talvez se reduce la varianza en la estimativa

Al momento de seleccionar variables comunmente en el conjunto de entrenamiento
mientras más variables existan, menos residuos quedaran. Sin embargo,
algunas veces en el conjunto de prueba los residuos disminuyen hasta cierto punto
se estancan y comienzan a subir de nuevo debido al overfitting.
Por lo que es recomendado no usar muchas variables.

Enfoque de selección de modelo: divide las muestras

* Ningún método es mejor cuando los datos/tiempo computacional lo permite
* Enfoque
	1) Divide los datos en entrenamiento/pruebas/validación
	2) Trata el conjunto de validación como datos de pruebas, entrena
	todos los modelos con el conjunto de entrenamiento y selecciona el mejor en validación
	3) Para evaluar apropiadamente el rendimiento en nuevos datos aplicalo al
	conjunto de pruebas
	4) Debes dividir los datos y rehacer los pasos 1-3
* Dos problemas comunes
	* Datos limitados 
	* Complejidad computacional

El error esperado (MSE) = error irreductible + Sesgo^2 + Varianza

Aveces puedes tener más variables que datos = más columnas que filas.
Eso es malo.

Algunas cosas que se buscan al momento de escoger una penalización:

* Reducir la complejidad
* Reducir la varianza
* Respeta la estructura del problema

Regresión de Ridge

* Lambda controla el tamaño de los coeficientes
* Lambda controla la cantidad de regularización
* Cuando lambda tiende a cero obtenemos la solución de minimos cuadrados
* Cuando lambda tiene a infinito los parametros tienden a cero

c = 1/lambda

Lasso

Usa el signo de la penalización y el valor del coeficiente es el coeficiente 
original menos la penalización (Encoge los datos). A muchos les gusta este enfoque
porque algunos coeficientes tienden a cero y eso hace fácil la escogencia de 
caracteristicas.
