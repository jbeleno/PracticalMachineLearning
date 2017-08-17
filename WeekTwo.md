# El paquete caret (para R)

* Disponible en este [link](http://topepo.github.io/caret/index.html)

Algunas funcionalidades son:

* Pre-procesamiento (limpieza de datos). Por ejemplo, preProcess.
* Segmentación de datos. Por ejemplo, createDataPartition, createResample y createTimeSlices.
* Funciones de entrenamiento y pruebas. Por ejemplo, train y predict.
* Comparación de modelos. Por ejemplo, confusionMatrix.

También tiene un buen número de algoritmos de machine learning:

* Analisis lineal de discriminantes
* Regresión
* Naive Bayes
* Máquinas de Soporte Vectorial (SVM)
* Arboles de regresión y clasificación
* Árboles aleatorios
* Boosting
* etc.

Tutoriales: [aquí](https://www.r-project.org/conferences/useR-2013/Tutorials/kuhn/user_caret_2up.pdf) y [aquí](https://cran.r-project.org/web/packages/caret/vignettes/caret.pdf)

Paper: [aquí](https://www.jstatsoft.org/article/view/v028i05)

# Remuestreo en el control de los entrenamientos

* method
	* boot = bootstraping
	* boot632 = bootstraping con ajuste
	* cv = Validación cruzada
	* repeatedcv = Validación cruzada repetida
	* LOOCV = Validación cruzada dejando uno fuera
* number
	* Para boot/validación cruzada
	* Número de submuestras a tomar
* repeats
	* número de veces a repetir el submuestreo
	* Si es grande, esto puede volver más lento el proceso

No olvides usar una semilla. Generalmente, está bien usar una semilla
de manera general o una semilla para cada remuestreo cuando se usa computación
paralela.

# Generar gráficos de las predicciones

* featurePlot para graficar cada variable contra otra
* qplot para graficar 2 variables, podemos colorear las categorias de 
valores usando datos de una tercera variable con la variable colour.
* geom_smooth sirve para agregar suavizadores con regression
* función cut2 en el paquete hmisc sirve para categorizar variables continuas
y con qplot geom=c("boxplot", "jitter") se pueden graficas esas 
categorias con datos como la media y desviación estándar y los puntos
en cada categoria. Los puntos permiten ver graficamente si la
tendencia cuenta con suficientes datos para hacerlo realidad.
* table te permite ver los datos en forma de tablas.
* prop.table provee tablas con valores normalizados.
* Gráficos de densidad son útiles para distribuciones continuas
qplot con geom="density"
* grid.arrange permite dibujas varios graficos en uno solo.

Para resumir, debes buscar desbalances en las salidas/predictores,
outliers, grupos de puntos que no son explicados por un predictor,
variables no simetricas.
