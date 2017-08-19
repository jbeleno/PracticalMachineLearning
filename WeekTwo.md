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

# Pre-procesamiento básico

* Es una buena practica estandarizar variables cuando los valores son bastante
asimetricos (cuando la desviación estándar es mucho mayor a la media). 
Por ejemplo, en el conjunto de datos de spam, los correos
suelen tener muchas letras mayúsculas o pocas.
* Estandarizar: Restas el valor original al promedio y lo divides entre la
desviación estándar. Para el caso del conjunto de pruebas usamos el 
promedio y desviación estándar del conjunto de entrenamiento así los valores
no queden cerrados luego de la estandarización (promedio = 0 y 
desviación estándar = 1)
* Siempre se deben usar los datos usados en el conjunto de entrenamiento
para generar el pre-procesamiento en los datos de pruebas.

preObj <- preProcess(training[,-58], method=c("center", "scale"))
trainCapAveS <- predict(preObj, training[,-58])$capitalAve
mean(trainCapAveS) // 0
sd(trainCapAveS) // 1
testCapAveS <- predict(preObj, testing[,-58])$capitalAve
mean(testCapAveS) // ~ 0
sd(testCapAveS) // ~ 1

Puedes usar el pre-procesamiento directamente como argumento del método train.

Transformación Box-Cox es una familia de transformaciones usadas en
estadística para corregir sesgos en la distribución de errores, corregir
varianzas desiguales (para diferentes valores de la variable predictora) y 
especialmente para corregir la no linealidad de la relación. Usa datos 
continuos para volverlos un poco más normales (gausianas).

Gráfico Q-Q esun método grafico para ver las diferencias entre las diferencias
entre las distribución de una probabilidad de una población de la que se ha
extraído una muestra aleatoria y una distribución usada para la comparación. 
Si la distribución de la variable es la misma se obtendrá una linea recta.
Especialmente cerca del centro.

Puedes imputar datos usando preProcess(..., method="knnImput")

# Creación de caracteristicas (covariate = features)

1) En algunos casos es útil convertir los datos brutos que tenemos en algo 
que sea más fácil de procesar para un algoritmo de Machine Learning (caracteristicas). 
Por ejemplo, convertir los textos en una matrix de bag of words y agregar 
otros datos de resumen de los datos como el número de palabras en mayúsculas.

* Depende en gran medida de la aplicación
* El acto de equilibrar las cosas es resumir vs perdida de información
* Ejemplos:
	* Archivos de texto: frecuencia de las palabras, frecuencia de n-gramas, frecuencia de letras en mayúscula
	* Imágenes: bordes, esquinas, manchas, arrugas, etc.
	* Páginas web: número y tipos de imágenes, posición de los elementos,
	colores, videos (A/B testing)
	* ersonas: Peso, altura, color del cabello, sexo, país de origen.
* Mientras más conocimiento del sistema tienes, mejor trabajo haras
* Si dudas, es mejor usar más caracteristicas
* Puede ser automatizado, pero usalo con precaución

2) Transformar las caracteristicas de manera organizada. Por ejemplo,
elevar al cuadrado el número de número de palabras en mayúsculas.

* Más necesario para algunos métodos (regresión, SVMs) que para otros
árboles de clasificación.
* Debe ser aplicado solo en el conjunto de entrenamiento.
* El mejor enfoque es a traves de analisis exploratorio (graficas y generar tablas)
* Nuevas caracteristicas deben ser adicionadas a los conjuntos de datos.

Puedes usar variable dummies para convertir variables con categorias en 
nuevas columnas representar 1 cuando esa variable existe en el registro
o 0 cuando no.

dummies <_ dummyVars(wage ~ jobclass, data=training)
head(predict(dummies, newdata=training))

Puedes eliminar las columnas que no tienen varianza (o es casi nula)
Para ver cuales son esas columnas usas:
nsv <- nearZeroVar(training, saveMetrics=TRUE)
nsv

Una buena idea es buscar en Google "feature extraction for [data type]"

Creación de caracteristicas para Deep Learning [aquí](http://www.cs.nyu.edu/~yann/talks/lecun-ranzato-icml2013.pdf)

# Principal Component Analysis

Frecuentemente, el conjunto de datos va a tener muchas variable y algunas
veces ellas estaran correlacionadas entre ellas. En ese caso no es necesario
incluir cada variable en el modelo. Talvez quieres incluir una variable
que resuma la mayoria de la información en esas variables cuantitativas.

M <- abs(cor(training[,-58])) // Las últimas 58 columnas son resultados
diag(M) <- 0 // Como la autocorrelación es siempre 1, ponemos la diagonal en 1
which(M > 0.8, arr.ind=T) // Cuales variables tienen alta correlación con otras

Idea básica de PCA

* Nosotros talvez no necesitamos todas las variables predictoras
* Una combinación de predictores puede ser mejor
* Debemos escoger esta combinación para capturar la mayor cantidad de información
posible
* Beneficios:
	* Menor número de predictores
	* Menos ruído (debido al promedio)
* Para hacerlo realidad rotamos los ejes X e Y usando transformaciones 
lineares y escogemos solo la nueva variable X rotada como caracteristica.

Problemas relacionados

Tienes multiples variables X1, ..., Xn entonces X1 = (X11, ..., X1n)

* Buscar un nuevo conjunto de variables multivariadas que son no correlacionadas
y explicar lo más posible la varianza.
* Si pones todas las variables juntas en una matriz, buscar la mejor matriz creada
con el menor número de variables posibles que explique la varianza en los datos
originales.

La meta principal es estadística y la segunda es de compresión de datos.

Hay dos soluciones:

* SVD: Si X es una matriz con cada variable en una columna y cada observación en
una fila, entonces el SVD es una "matriz de decomposición". X = UDV^T, donde
las columnas de U son ortogonales (vectores singulares a la izquierda), las
columnas de V son ortogonales (vectores singulares a la derecha) y D es una matriz
diagonal (valores solos).
* PCA: Los componentes principales son iguales a valores singulares a la derecha
si primero escalas (restar el promedio, dividir por la desviación estándar) las
variables. La ventaja de PCA es que puedes aplicar la rotación de ejes para más
de dos variables. Podemos obtener la matriz de rotación para ver los como están
hechos los componentes principales.

Antes de aplicar un PCA a todos los datos puedes usar log10 para (todos los datos
y sumar 1), esto hace que el comportamiento de las variables sea un poco más
gausiano porque algunas variables pueden ser normales pero tener algo de asimetria. Por lo tanto, PCA es un poco más sensible

PCA sirve mejor para modelos de tipo lineal, puede hacer más difícil la 
interpretación de predictores, primero debes mirar los outliers, transforma primero
usando logs o Box Cox y dibuja los predictores para identificar problemas.

# Predecir con regresión

* Adecuar un modelo de regresion simple
* Conectar nuevas caracteristicas (covariates) y multiplicar por los coeficientes.
* Útil cuando el modelo linear es (casí) correcto

Pros:

* Fácil de implementar
* Fácil de interpretar

Contra:
* Frecuentemente tiene un rendimiento pobre en configuraciones no lineales.

Para obtener los errores usamos RMSE, el error en el conjunto de tests es una
mejor estimativa.

# Predecir con regresión usando multiples covariables.

* featurePlot para ver que variables están relacionadas con otras
* Una vez identificadas las variables relacionadas, podemos graficarlas mejor
usando qplot
* qplot tambien tiene el parametro colour que permite distingir una tercera
variable y colorear los puntos.
* Podemos usar train para entrenar un modelo usando las variables seleccionadas
despues de escoger las covariables.
* Puedes crear gráficos diagnosticos, donde gráficas los residuos vs las predicciones
del modelo usando plot.
* Sobre ese gráfico de residuos puedes colorearlo con variables que no fueron
usadas en el modelo.
* Podemos graficar los residuos vs el índice, si los residuos tienen una
tendencia o clusters, significa que están faltando variables en el modelo.
* Graficar los valores predichas vs la verdad en el conjunto de pruebas.
En el mejor de los casos hay una gráfica Y = X. Sobre ese grafico puedes graficar
otras variables como el tiempo.