# Prediciendo con árboles

* Iterativamente dividir las variables en grupos
* Evaluar la "homogeneidad" dentro de cada grupo
* Dividir de nuevo si es necesario

Pros:

* Fácil de interpretar
* Mejor rendimiento en configuraciones no lineales

Contra:

* Sin podar o hacer validación cruzada puede llevar a overfitting
* Difícil de estimar la incertidumbre
* Los resultados pueden ser variables

Algoritmo básico

1) Comienza con todas las variables en un grupo
2) Busca variables/divisiones que mejor separen las salidas
3) Divide los datos entre dos grupos("hojas") en esa división ("nodo")
4) Dentro de cada división, busca la mejor variable/división que separe las
salidas
5) Continuar hasta que los grupos sean demasiado pequeños o suficientemente
"puros"

Medidas de impureza

* Error de clasificación (0 = pure, 0.5 = not pure)
* índice Gini (0 = pure, 0.5 = not pure)
* Desviación o Ganancia de información (0 = pure, 1 = not pure)

Notas

* Árboles de clasificación es un modelo no lineal
* Usa iteraciones entre variables
* Transformaciones de datos pueden ser menos importantes (transformaciones monotonas)
* Árboles puede también ser usadas para problemas de regresión (salida continua)
* `caret` usa `party`y `rpart`
* Fuera de `caret` existe `tree`
* Para gráficar puedes usar `rattle

# Bagging = Bootstrap aggregating

La idea es que para datos complejos puedes usar varios modelos y sacar un
promedio entre eses modelos, de esa manera obtener un rendimiento mejor
y balance entre bias y varianza.

Idea básica
1) Hacer un remuestreo con reposición y calcular predicciones
2) Promediar por voto de la mayoria

Notas:
* Bias similar
* Varianza reducida
* Funciones no lineales más útiless
* Usualmente usado con árboles -- una extensión de estos es Random Forest
* Muchos modelos usan bagging en `caret`

Curva de Loess es similar a Splines

Puedes usar el comando `train`con `bagEarth`,`treebag` y `bagFDA`. También,
pues usar la función `bag`.

# Random Forest

1) Muestras usando bootstrap
2) En cada división (un subconjunto de datos), ejecutar bootstrap sobre las
variables
3) Hacer crecer varios árboles y votar

Pros:

* Precisión, otro algoritmo bueno usa Boosting para concursos de predicciones

Contra:

* Velocidad
* Interpretabilidad
* Overfiting (se puede evitar usa `rfcv`)

# Boosting

1) Haz muchos (posibles) predictores débiles
2) Pesalos y sumalos
3) Obten in clasificador más fuerte

Idea básica

1) Comienza con un conjunto de clasificadores h1, ..., hk.
Por ejemplo, todos los posibles árboles, todos los posibles modelos
de regresión, todos los posibles cortes.

2) Crea un clasificador que combine las funciones de clasificación: 
f(x) = sgn(SUM(at * ht(x)))
	* El objetivo es minimizar el error (en el conjunto de entrenamiento)
	* Interactivo, selecciona un h a cada paso
	* Calcula los pesos basados en el error
	* Da más valor a los puntos que están mal clasificados y no están en el modelo
	y selecciona el siguiente h

Adaboost es el clasificador Boost más famoso

Notas:

* Boosting puede ser usado en cualquier subconjunto de clasificadores
* Una gran subconjunto el gradient boosting
* R tiene múltiples bibliotecas de boosting. Las diferencias incluyen la 
escogencia de las funciones básicas de clasificación y reglas de combinación
	* `gbm` - boosting con árboles
	* `mboost` - modelo basado en boosting
	* ada - boosting estadístico basado en regresión logistica aditiva
	* gamBoost para modelos boosting generalizados y aditivos

Nota: Tutoriales [aquí](https://www.cc.gatech.edu/~thad/6601-gradAI-fall2013/boosting.pdf), 
[aquí](http://webee.technion.ac.il/people/rmeir/BoostingTutorial.pdf),
[aquí](http://www.netflixprize.com/assets/GrandPrize2009_BPC_BigChaos.pdf) 
y [aquí](https://kaggle2.blob.core.windows.net/wiki-files/327/09ccf652-8c1c-4a3d-b979-ce2369c985e4/Willem%20Mestrom%20-%20Milestone%201%20Description%20V2%202.pdf)

# Predicciones basadas en modelos

1) Asume que los datos siguen un modelo probabilistico
2) Usa el teorema de Bayes para identificar clasificadores optimos

Pros:

* Puede tomar ventaja de la estructura de los datos
* Puede ser computacionalmente conveniente
* Son razonablemente precisos en problemas de la vida real

Contra:

* Hace suposiciones adicionales acerca de los datos
* Cuando el modelo es incorrecto, puedes obtener una precisión reducida

Enfoque:

1) La meta es crear un modelo parametrico para la distribución condicional
P(Y = k | X = x), donde k es una clase especifica y x es un conjunto de predictores
2) Un enfoque típico es aplicar el teorema de Bayes
3) Tipicamente se proveen las probabilidades a priori
4) Una opción común para una distribución gausiana
5) Estimar los parametros de los datos
6) Clasificar la clase con el mayor valor de P(Y = k | X = x)

Clasificadores usando este enfoque:

* Analisis linear de discriminantes asume que la función es una gausiana
multivariada con las mismas covarianzas
* Analisis cuadratico de discriminantes asume que la función es una gausiana
multivariada con diferentes covarianzas
* Las prediciones basadas en modelos asumen versiones más complicadas
de la matriz de covarianza
* Naive Bayes asume independencia entre las caracteristicas del modelo
	* Es útil cuando hay muchas variables binarias o variables categoricas.
	* Es usada en clasificación de textos.

Notes: [The Elements of Statistical Learning](https://web.stanford.edu/~hastie/Papers/ESLII.pdf)


