# Proyecto de Análisis Exploratorio 

Realizar un análisis exploratorio requiere de una buena aplicación de los conceptos estadísticos y mucha imaginación, donde el objetivo es determinar cuales deben ser los puntos importantes o necesarios para entender una base de datos y obtener las conclusiones que permitan tomar las decisiones que más beneficien a una organización.

Este trabajo busca que usted explore la base de datos del tema que desee, establesca una pregunta y  usando gráficos y medidas estadísticas encuentre una solución extrayendo la respuesta de la base de datos.

La forma más fácil de averiguar qué investigar, es preguntarle a las partes interesadas (otras personas que se preocupan por lo que está en sus datos y que les gustaría saber) qué considerarían como la información más importante.

Hay algunas pautas generales que puede usar para averiguar qué información incluir en un panel, por ejemplo:

* ¿Qué información está cambiando relativamente rápido? 
* ¿Qué información es la más importante para tu misión? Si eres una empresa, las cosas como el dinero o los usuarios probablemente serán muy importantes, pero si desea implementar una política económica o financiera que debería mirar primero.
* ¿Qué afectará las decisiones que usted u otros deberán tomar? ¿Está ejecutando pruebas A / B y necesita elegir qué modelo mantener basado en ellas?  ¿Hay algún factor externo que pueda afectar su investigación?.
* ¿Qué cambios ha hecho?  han afectado los resultados , ¿Representa mejor la idea que usted desea mostrar?.

## Datos:

Los datos que se presentan a continuación pertenecen a una pagina web que se llama 
<a href="https://www.kaggle.com/">kaggle</a> en donde se recopilan más de un millon de códigos en python y R, y es el punto de partida para la investigación en análisis de datos de muchas empresas, en esta página usted encontrará los kernels, que son códigos escritos en R o Python y que se pueden correr directamente en la pagina, tambiém hay bases de datos como las que se presentan a continuación de diversos temas y también una comunidad de personas que trabajan todo el tiempo con análisis de datos y que pueden aportar en el trabajo que ustedes desean realizar. Es importante aclarar que el trabajo que usted va a realizar es diferente a lo que se presenta en los kernels, ya que cada pregunta es diferente y por lo tanto se considera plagio usar un proyecto desarrollado por algún usuario de kaggle y presentarlo como propio. Usted puede usar algunos ejemplos para lograr algunos tipos de gráficos como los que ellos presentan para manejar los datos, pero el trabajo de ellos no puede ser el suyo. 


 Cada uno de estos links lo lleva a uno de los datos en donde se encuentra la descripción de cada base de datos.

* <a href="https://www.kaggle.com/theworldbank/world-bank-health-population/home/">WB Salud y población</a>
* <a href="https://www.kaggle.com/gsutters/the-human-freedom-index/home/">Índice de libertad de expresión</a>
* <a href="https://www.kaggle.com/fdic/bank-failures/">Default Bancarios</a>
* <a href="https://www.kaggle.com/ntnu-testimon/paysim1/home/">Fraudes en transacciones</a>
* <a href="https://www.kaggle.com/gemartin/world-bank-data-1960-to-2016/home/">WB Fertilidad, Población y Expectativa de vida</a>
* <a href="https://www.kaggle.com/theworldbank/worldwide-economic-remittances/">WB remesas</a>
* <a href="https://www.kaggle.com/johnolafenwa/us-census-data/home/">Salarios</a>



Realice un análisis estadístico, aprovechando lo que hemos aprendido hasta ahora en este curso. Escriba un informe, como un archivo de notas de R (Rmd). 

El archivo Rmd debe leer los datos directamente desde una fuente de Internet y se debe subir en este repositorio como htlm y Rmd.

 


## Expectativas del trabajo

* Debe explicar algunos antecedentes de los datos que eligió y motivar al lector a apreciar el propósito de su análisis de datos.
* Uso de métodos estadísticos adecuados.
* Los modelos y métodos que utilice deben explicarse completamente, ya sea por referencias o dentro de su informe. Cuando use una referencia para señalar al lector descripciones en otros lugares, debe proporcionar un breve resumen en su propio informe para que sea autónomo. Aunque va a enviar su código fuente, no debe esperar que el lector lo estudie.
* Debe decir lo que ha concluido, así como describir las cosas que le hubiera gustado hacer que estaban fuera del alcance.
* Centrarse en unos pocos datos, cuidadosamente explicados y justificados con ayuda de figuras, tablas, estadísticas y pruebas de hipótesis. Es posible que desee probar muchas cosas, pero solo escriba evidencia que respalde cómo los datos lo ayudan a obtener de su pregunta sus conclusiones. La inclusión de material que es de relevancia límite o que no se explica completamente hace que sea más difícil para el lector apreciar su análisis.

## Método de calificación

El método de calificación se divide en 5 partes cada una con un número de puntos de acuerdo a la importanica dentro del trabajo.

### Introducción del trabajo 6 puntos

La introducción debe proporcionar antecedentes de los datos que analiza y motivar al lector a apreciar el propósito de su análisis de datos.

6-5 puntos si, la pregunta está claramente explicada, con motivación. 
4-3 puntos si, la motivación es débil pero no ausente.
2-1. puntos si, no intenta explicar por qué se eligieron los datos o cuál es el propósito de realizar un análisis estadístico de los mismos.

### Aplicación de las herramientas de forma apropiada 15 puntos

15-11 puntos si, se utilizaron apropiadamente las herramientas del programa. La elección de los métodos es impulsada por los objetivos del proyecto.

10-6 puntos si, se utiliza una variedad las herramientas del programa, pero probaron  métodos descritos e sin prestar atención a su rol particular en los objetivos del proyecto.

5-1 puntos si, no aplican métodos relevantes del curso, o métodos irrelevantes aplicados.

### Armonía en la presentación del documento usando referencias externas 10 puntos

10-7 puntos Si, las referencias se utilizan para respaldar aspectos del informe no son independientes. Es comparable a lo que se espera en un artículo académico publicado.


6-4 puntos Si, se intenta hacer referencia y seguir el estilo de la redacción académica.


3-1 puntos Si, no hay referncias y la redacción no es buena.

### Conclusión 3 puntos 

3 puntos si, Se percibe una conlusión clara refirienddose a reusltados a partir del documento 

2 puntos si, Existe una conclusión basado en el proceso del documento. 

1 punto si, Hay una conclusión pero sin conexión con los resultados. 


### Presentación 6 puntos

6-5 puntos si, Las figuras, tablas y resultados de las pruebas se discuten y explican adecuadamente. Para cada resultado presentado, queda claro cómo contribuye esto al desarrollo hacia las conclusiones del documento.

4-3 puntos si, La presentación en su mayoría es adecuada, pero con un espacio sustancial para la mejora.

2-1 puntos si, Presentar una lista de análisis realizados, sin mucha atención a explicar qué se hizo y por qué.


## Entrega de resultados y Otros 


* Tanto el archivo RMD como lel html se deben subir en este repositorio con el número del grupo.
* El día de la entrega es el 25 de julio a las 9:00 am.
* La presentación será el 25 de Julio.


