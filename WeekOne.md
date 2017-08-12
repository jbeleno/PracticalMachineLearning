# El dogma central de la predicción

1) Tienes un conjunto de datos
2) Tomas una muestra de ese conjunto de datos (Conjunto de entrenamiento)
que represente bien las diferentes clases de datos que quieres predecir.
3) Creas una función de predicción basado en los datos de entrenamiento que
separe bien las clases de acuerdo a sus caracteristicas.

Aunque la mayoria de los temas de mayor impacto mediatico se centran en el 
tercer paso, los otros dos pasos también son importantes (ver el ejemplo de
Google Flu Trend)

# Componentes de un predictor

1) Pregunta: bien definida. ¿Qué quieres predecir? ¿Con qué estás 
intentando predecirlo?
2) Datos de entrada: Debes recolectar los mejores datos que puedas
para usarlos como combustible para la predicción.
3) Caracteristicas: Puedes usar los datos de entrada como están o puedes
computar otros datos que creas puedan ser útiles para la predicción.
4) Algoritmo: Algoritmo de aprendizaje de máquina en acción.
5) Parametros: Estimar los parametros que mejoren el rendimiento de los
algoritmos.
6) Evaluar: Evaluar los resultados obtenido por el algoritmo ajustado con 
los parametros.

"La combinación de algunos datos e un deseo dolorido por una respuesta 
no garantiza que una respuesta razonable pueda ser extraida de un cuerpo 
de datos dado" John Tukey

Debes saber cuando rendirte, especialmente cuando no tienes los datos para 
responder la pregunta.

# Basura entra, Basura sale.

1) Puede ser fácil. Por ejemplo, usar datos de evaluación de peliculas para
predecir cual será la evaluación de una nueva pelicula.
2) Puede ser dificil. Por ejemplo, usar datos geneticos y tratar de predecir
enfermedades.
3) Depende en qué es una "buena predicción".
4) Frecuentemente, más datos significa mejores modelos.
5) El paso más importante: Recolectar los datos correctos

# Las caracteristicas importan

Propiedades de buenas caracteristicas

* Conducen a compresión de datos.
* Tienen información relevante.
* Son creadas a partir de conocimiento aplicado de expertos.

Errores comunes

* Intentar automatizar la selección de caracteristicas. Se requiere mucho cuidado
para automatizar esto.
* No prestar atención a las peculiaridades de los datos (puntos fuera de la curva, 
errores de medición, etc.).
* Desechar información innecesariamente.

Nota: los algoritmos importan menos de lo que piensas.

# Cuestiones a considerar

* Interpretabilidad
* Simplicidad
* Precisión
* Rápidez (para entrenar y para evaluar)
* Escalabilidad

Casi siempre es un intercambio de precisión con alguna de las cuestiones 
presentadas encima.

# En la muestra versus fuera de la muestra

Error en la muestra: La tasa de errores que obtienes en el mismo conjunto
de datos que usaste para construir tu predictor. Algunas veces llamado 
error de resustitución.

Error fuera de la muestra: La tasa de errores que obtienes en un nuevo 
conjunto de datos. Algunas veces llamado error de generalización.

Ideas principales:

1) Error fuera de la muestra es lo que te importa
2) Error en la muestra < error fuera de la muestra
3) La razón es overfitting
	* Emparejar tu algoritmo con los datos que tienes

# Overfitting

* Datos tienen dos partes: Señal y Ruido
* El objetivo del predictor es encontrar la señal
* Siempre puedes diseñar un predictor perfecto para la muestra
* Capturas los dos señal + ruido cuando haces eso
* El rendimiento de esos predictores no es tan bueno en nuevas muestras

# Diseño de estudio de predicción

1) Define tu tasa de error
2) Divide los datos en: entrenamiento, pruebas y validación (opcional)
3) En los datos de entrenamiento, escoge las caracteristicas. Usa validación
cruzada
4) En los datos de entrenamiento, establece una función de predicción. Usa
validación cruzada
5) Si no hay validación aplica el mejor predicto que tengas en el conjunto
de entrada UNA solo vez
6) Si hay validación. Aplica tu mejor predictor en el conjunto de datos de pruebas
y refinalo. Finalmente, aplica el predictor en el conjunto de datos de 
validación UNA sola vez

# Evita muestras de tamaño pequeño

* Supón que estas prediciendo una salida binaria. Por ejemplo, enfermo/sano, 
clic / no clic.
* Un clasificador es lanzar una moneda
* Las probabilidades de un clasificador perfecto es aproximadamente:
(0.5)^n, donde n es el tamaño de la muestra. Entonces para n= 1, p=0.5.
Para n=2, p= 0.25. Para n=10, p=0.001

# Regla de oro para diseño de estudios de predicción

* Si tienes una muestra grande, entonces 60% es de entrenamiento, 20% es para
pruebas y 20% para validación
* Si tienes muestras de tamaño mediano, entonces 60% para entrenamiento y
40% para pruebas
* Si tienes muestras de tamaño pequeño, entonces haz validación cruzada y
reporta advertencias de un conjunto de datos pequeño

# Algunos principios para recordar

* Establece un conjunto de pruebas/validación aparte y no lo mires
* En general, una muestra aleatoria de entrenamiento y pruebas
* Tus datos deben reflejar una estructura del problema.
* Si tus datos evolucionan con el tiempo, divide entrenamiento/pruebas en
pedazos de tiempo (llamado backtesting en finanzas)
* Todos los subconjuntos deben reflejar tanta diversidad como sea posible
* Asignaciones aleatorias lo hacen
* También puedes tratar de balancear por caracteristicas, pero esto es difícil

# Tipos de errores

En general (para clases binarias), positivo = identificado y negativo = rechazado. 
Por consiguiente:

Verdadero positivo = correctamente identificado
Falso positivo = incorrectamente identificado
Verdadero negativo = correctamente rechazado
Falso negativo = incorrectamente rechazado

Por ejemplo, pruebas medicas:

Verdadero positivo = personas enfermas correctamente diagnosticadas como enfermas
Falso positivo = personas saludables incorrectamente identificadas como enfermas
Verdadero negativo = personas saludables correctamente identificadas como saludables
Falso negativo = personas enfermas incorrectamente identificadas como saludables

Test = Predictor, Disease = Real true

Sensitivity => Pr (positive test | disease) => TP / (TP + FN)
Specificity => Pr (negative test | no disease) => TN / (FP + TN)
Positive predictive value => Pr (disease | positive test) => TP / (TP + FP)
Negative predictive value => Pr (correct outcome) (TP + TN) / (TP + FP + FN + TN)

En datos continuos buscamos minimizar la media de la raiz cuadrada del error al cuadrado RMSE

# Errores comunes

1) La media de los errores al cuadrado (MSE) o el RMSE en datos continuos es
sensible a punto fuera de la curva.
2) La desviación absoluta de la mediana (Median absolute deviation) 
en datos continuos es frecuentemente más robusta
3) Optimizar sensividad (Recall) si quieres perder pocos positivos
4) Optimizar especificidad si quieres pocos negativos enmascarados de positivos
5) Optimizar precision si quieres un equilibrio entre los falsos 
positivos/negativos igualmente
6) Concordancia. Por ejemplo, kappa.

# Caracteristicas del funcionamiento del receptor (ROC)
Sirve para medir la calidad de que tan bueno es un algoritmo de predicción.

¿Por qué una curva?

* En clasificación binaria, predices una de dos categorias.
* Sin embargo, tus predicciones son frecuentemente cuantitativas. Por ejemplo,
probabilidades de estar vivo, predicciones en una escala de 1 a 10
* El corte que escojes da un resultado diferente
* Se usa receiver operating characteristic para calcular eso.
Eje x es 1 - Especifidad (la probabilidad de ser un falso positivo).
El eje y es sensitividad (la probabilidad de ser un verdadero positivo).
Esa curvas sirven para ver la compensaciones de cada algoritmo.
A mayor área bajo la curva, mejor rendimiento tiene el predictor.
AUC = 0.5 es adivinar. AUC = 1 es un clasificador perfecto. 
Un clasificador con AUC arriba de 0.8 es considerado "bueno".