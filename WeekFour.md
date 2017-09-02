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

# Combinación de predictores

* Puedes combinar clasificadores al usar el promedio o votación
* Combinar clasificadores mejora la precisión
* Combinar clasificadores reduce la interpretabilidad
* Boosting, bagging y Random Forest son variantes de este tema

Nota: El ganador del premio Netflix (BellKor) uso una combinación de
107 predictores

1) Bagging, boosting y Random Forest combinan clasificadores similares
2) Model stacking y model ensembling combinan diferentes clasificadores

Notas
* Inclusive votación por mayoria puede ser útil
* Modelo típico para datos binarios/multiclase
	* Crea un número impar de modelos
	* Predice con cada modelo
	* Predice la clase por voto mayoritario
* Sin embargo, puede ser dramaticamente más complicado
	* `caretEnsemble` usar bajo tu propio riesgo, está en desarrollo

# Forecasting

Es usualmente aplicada a datos de series temporales.

* Los datos dependen del tiempo
* Hay tipos de patrones especificos
	* Tendencias - incremento/decremento a largo plazo
	* Patrones por temporadas - patrones relacionados a la parte de la semana, 
	mes, año, etc.
	* Ciclos - patrones que levantan y caen periodicamente
* Submuestreo en conjuntos de entrenamiento/pruebas es más difícil
* Un problema similar aparece en datos espaciales
	* Dependencia entre observaciones cercanas
	* Efectos en lugares especificos
* Usualmente, el objetivo es predecir una o más observaciones en el futuro
* Todas las predicciones estándar pueden ser usadas (¡con precaución!)

Cuidado con las correlaciones espurias. Puedes buscar correlacciones entre terminos
usando http://wwww.google.com/trends/correlate

La función `decompose()` recibe como parametro una serie temporal y la
descompone en datos observados, tendencia, temporadas y aleatorio.

Usamos la función `window` para crear conjuntos de datos juntos en el tiempo
para dividir los conjuntos de entrenamiento y pruebas.

Para resumir los datos de un segmento de datos podemos usar promedio simple en 
movimiento o suavización exponencial simple que da más valor a los datos más
recientes.

Notas:

* Existe un campo completo dedicado a forecasting y predicción en series temporales
* Para empezar podemos usar el libro "Forecasting: principles and practice" de
Rob Hyndman
* Precaución 
	* Esté pendiente de las correlaciones espuria
	* Se cuidadoso acerca de que tan lejos predices (extrapolación)
	* Se cuidadoso de las dependencias sobre el tiempo
* `quantmod` y `quandl` son bibliotecas para datos de finanzas

# Predicción no supervisada

* Aveces no conoces las etiquetas para la predicción
* Para construir un predictor
	* Crea clusters
	* Nombra los clusters
	* Crea un predictor para los clusters
* En nuevos datos
	* Predice los clusters

Algunos algoritmos son:
* K-means que agrupa cada punto de acuerdo a los k puntos vecinos

