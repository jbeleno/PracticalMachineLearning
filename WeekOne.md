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