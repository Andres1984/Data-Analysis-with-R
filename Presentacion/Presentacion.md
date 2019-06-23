
---
title: "Exploratory Data analysis with R"
author: "Andrés Martínez"
date: "25 de Junio 2019"
css: styles.css
bibliography: B.bib
link-citations: yes
logo: LOGU.png
biglogo : LOGU.png
site: "bookdown::bookdown_site"
output:
  ioslides_presentation: default
  widescreen: true
  

---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = FALSE)
require("knitcitations")
options("citation_format" = "pandoc")
```


```{r, echo=FALSE, message=FALSE,results='hide',warning=FALSE}
#install.packages("bookdown")
#Librerias que se van a utilizar
library(kableExtra)# Tablas
library(quantmod)# Descarga de datos
library(knitcitations)#Citaciones
library(knitr)#R Markdown
library(psych)# Medidas descriptivas
library(RCurl)# La dirección web
library(readr)# La base de datos
library(dplyr)# Transformación de tablas
library(plotly)# Gráficos Interactivos
library(ggplot2)# Gráficos 
library(corrplot)# Gráfico de Correlación
library(quadprog)# Programación puede necesitar otra 
library(tidyquant)
library(tseries)
library(TSA)
library(rugarch)
library(car)
library(MTS)
library(lmtest)
library(forecast)
library(gganimate)
```

```{r, echo=FALSE, message=FALSE,results='hide',warning=FALSE}
library(readxl)
Datos <- read_excel("/Users/andresmartinez/Google Drive/Ucentral/2019-1/Investigacion/Datos/DatosVAR.xlsx")
Datos$Dates=as.Date(Datos$Dates)
library(xts)
Datos1=xts(Datos, order.by=Datos$Dates)
Datos1=Datos1[,2:17]
```



## Motivación



"En los años oscuros sólo aquellos con el poder o el ingreso (y algunos expertos selectos) poseían habilidades de lectura y escritura. Hoy en  día se argumenta que la alfabetización de la población (que no es del 100\%) junto con la invención de la tecnología impresa ha sido una de las mayores fuerzas emancipadoras de la historia moderna"
[@van1999computer]

"La ilustración es la facilidad humana de escribir de forma creativa textos, usando símbolos o infraestructura tecnológica. Esto permite que las personas representen sus ideas en textos que pueden ser interpretados por otras personas" [@vee2013understanding]

## Motivación


```{r, message=FALSE,echo=FALSE,warning=FALSE}
library(cowplot)
library(ggplot2)
p1 <- ggdraw() + draw_image("/Users/andresmartinez/Google Drive/Ucentral/InteR/Aufgaben/noL.jpg", scale = 0.9)
p2 <- ggdraw() + draw_image("/Users/andresmartinez/Google Drive/Ucentral/InteR/Aufgaben/iL.jpg", scale = 0.9)
plot_grid(p1, p2)
```



## Introducción


* R es un lenguaje y ambiente para gráficas y estadísticas computacionales.

* R está basado en el lenguaje S, originalmente desarrollado por John Chambers y colegas de AT&T Bell Labs a finales de los 70s e inicios de los 80s.

* R es un recurso libre con licencia gratuita. Fue desarrollado inicialmente por Robert Gentleman y Ross Ihaka en la Universidad de Auckland, New Zealand  en los 90s.

* R es conocido formalmente como "The R Project for Statistical Computing".  https://www.r-project.org






## Contenido

* Fundamentos
* Trabajo con datos cargados 
* Trabajo con datos de internet 
* Creación  de documentos Rmw
* Gráficos Ggplot
* Gráficos Plotly 
* Creación de documentos científicos



## Objetivos

* Identificar las ventajas de R en la estadística como herramienta para la investigación.

* Utilizar  las  herramientas  estadísticas  para  el  análisis  y  presentación  de  los  datos.

* Familiarizarse con los aspectos básicos de la programación estadística.
* Aprender a usar vectores y matrices en la programación.
* Crear funciones en R.
* Crear un documento / presentación LaTeX o HTLM.
* Crear un informe dinámico utilizando RMarkdown y Sweave.





## Recursos

Página del Curso

https://github.com/Andres1984/Data-Analysis-with-R

Páginas web

* https://cran.r-project.org

* https://www.rstudio.com

* https://stackoverflow.com


## Referencias del curso


* Zuur, A., Ieno, E. N., & Meesters, E. (2009). A Beginner's Guide to R. Springer Science & Business Media.

* Peter, D. (2002). Introductory statistics with R.

* Arratia, A. (2014). Computational finance. An Introductory Course with R, Atlantis Studies in Computational Finance and Financial Engineering, 1.

* Peng, R. (2012). Exploratory data analysis with R. Lulu. com.

* Torgo, L. (2011). Data mining with R: learning with case studies. Chapman and Hall/CRC.

## ¿Qué es exploración de datos?

Exploratory Data Analysis refers to the critical process of performing initial investigations on data so as to discover patterns,to spot anomalies,to test hypothesis and to check assumptions with the help of summary statistics and graphical representations.

## Estadísticas Descriptivas

```{r ,echo=FALSE, message=FALSE,results='hide'}
rend=as.data.frame( cbind(Delt(Datos$COP),Delt(Datos$BRL),Delt(Datos$ARS),Delt(Datos$MXN),Delt(Datos$CO1),Delt(Datos$CL1)))
rend=rend[-1,]
colnames(rend)=c("COP","BRL","ARS","MXN","BRENT","WTI")
```

```{r ,echo=FALSE, message=FALSE}
library(psych)
library('knitr')
library(dplyr)
rend1=as.data.frame(describe(rend))
kable(rend1[,3:4], format = "markdown",booktabs=TRUE,caption = "Estadísticas Descriptivas")
```



## Ejemplos 






```{r, echo=FALSE, message=FALSE,results='hide',warning=FALSE}
library(readxl)
Datos <- read_excel("/Users/andresmartinez/Google Drive/Ucentral/2019-1/Investigacion/Datos/DatosVAR.xlsx")
Datos$Dates=as.Date(Datos$Dates)
library(xts)
Datos1=xts(Datos, order.by=Datos$Dates)
Datos1=Datos1[,2:17]
```



```{r Precios, fig.width = 8, fig.height = 3.8,fig.cap=" Currencies Prices", echo=FALSE, message=FALSE}
par(mfrow=c(2,2))
plot(Datos$Dates,Datos$COP, type="l",col="green",main = "COP",xlab="Dates",ylab="Prices")
plot(Datos$Dates,Datos$BRL,type="l",col="red",main="BRL",xlab="Dates",ylab="Prices")
plot(Datos$Dates,Datos$ARS,type="l",col="blue",main="ARS",xlab="Dates",ylab="Prices")
plot(Datos$Dates,Datos$MXN,type="l",main="MXN",xlab="Dates",ylab="Prices")
```
## Retornos

```{r Returns, fig.width = 8, fig.height = 3.8,fig.cap=" Currencies Returns", echo=FALSE, message=FALSE}
rend=as.data.frame( cbind(Delt(Datos$COP),Delt(Datos$BRL),Delt(Datos$ARS),Delt(Datos$MXN),Delt(Datos$CO1),Delt(Datos$CL1)))
rend=rend[-1,]
colnames(rend)=c("COP","BRL","ARS","MXN","BRENT","WTI")
par(mfrow=c(2,2))
plot(rend$COP, type="l",col="green",main = "COP",xlab="",ylab="Returns")
plot(rend$BRL,type="l",col="red",main="BRL",xlab="",ylab="Returns")
plot(rend$ARS,type="l",col="blue",main="ARS",xlab="",ylab="Returns")
plot(rend$MXN,type="l",main="MXN",xlab="",ylab="Returns")
```

## Box PLot
```{r Boxplot, fig.width = 8, fig.height = 3.2,fig.cap=" Currencies Returns", echo=FALSE, message=FALSE}
p1 <- plot_ly(y = rend$COP, type = "box",name="COP") 
p2<-  plot_ly(y = rend$BRL,type="box",name="BRL")
p3<-  plot_ly(y = rend$ARS,type="box",name="ARS")
p4<-  plot_ly(y = rend$MXN,type="box",name="MXN")
p<-subplot(p1,p2,p3,p4)
p  
```



## Precios del Petroleo

```{r OIL,fig.width = 8, fig.height = 3.2, fig.cap=" OIL Prices", echo=FALSE, message=FALSE}
p <- plot_ly(x = Datos$Dates, y = Datos$CO1, fill = "tozeroy", name = "BRENT", type = 'scatter',
    fill = 'toself',
    fillcolor = 'rgba(168, 216, 234, 0.5)',
    hoveron = 'points',
    marker = list(
      color = 'rgba(168, 216, 234, 0.5)'
    ),
    line = list(
      color = 'rgba(168, 216, 234, 0.5)'
    )) %>%
  add_trace(x = Datos$Dates,y = Datos$CL1, fill = "tozeroy", name = "WTI",type = 'scatter',
    fill = 'toself',
    fillcolor = 'rgba(255, 212, 96, 0.5)',
    hoveron = 'points',
    marker = list(
      color = 'rgba(255, 212, 96, 0.5)'
    ),
    line = list(
      color = 'rgba(255, 212, 96, 0.5)'
    ))%>%
  layout(title = "OIL SPOT PRICES", 
         xaxis = list(title = "YEARS"),
         yaxis = list(title = "PRICES"))
p  
```

## Histogramas


```{r Hist,fig.width = 8, fig.height = 3.2, fig.cap=" Histogram", echo=FALSE, message=FALSE}
p1 <- plot_ly(alpha = 0.6) %>%
  add_histogram(x = rend$COP, name="COP") %>%
  add_histogram(x = rend$BRENT, name="BRENT") %>%
  layout(barmode = "COP")
p2 <- plot_ly(alpha = 0.6) %>%
  add_histogram(x = rend$BRL, name="BRL") %>%
  add_histogram(x = rend$BRENT, name="BRENT") %>%
  layout(barmode = "BRL")
p<-subplot(p1,p2,nrows = 2)
p 
```
## Histogramas


```{r Hist2,fig.width = 8, fig.height = 3.2, fig.cap=" Histogram", echo=FALSE, message=FALSE}
p3 <- plot_ly(alpha = 0.6) %>%
  add_histogram(x = rend$ARS, name="ARS") %>%
  add_histogram(x = rend$BRENT, name="BRENT") %>%
  layout(barmode = "ARS")
p4 <- plot_ly(alpha = 0.6) %>%
  add_histogram(x = rend$MXN, name="MXN") %>%
  add_histogram(x = rend$BRENT, name="BRENT") %>%
  layout(barmode = "COP") 
p<-subplot(p3,p4,nrows = 2)
p
```

## Correlación

```{r CORR,fig.width = 8, fig.height = 3.2,fig.cap='Correlation', echo=FALSE, message=FALSE,warning=FALSE,echo=FALSE}
library(corrplot)
corrplot.mixed(cor(rend))
```

## Animaciones


```{r Anim,fig.cap='Precio COP', echo=FALSE, message=FALSE,warning=FALSE,fig.width = 4, fig.height = 2.8}
p <- ggplot(
  Datos,
  aes(Dates, BRL)
  ) +
  geom_line(aes(color="BRL")) +
  geom_line(data=Datos,aes(x=Dates,y=MXN, color="MXN")) +
  geom_line(data=Datos,aes(x=Dates,y=ARS, color="ARS")) +
  scale_color_viridis_d() +
  labs(x = "Fechas", y = " Monedas") +
  theme(legend.position = "top")
p + transition_reveal(Dates)
```

##  Hans Rosling Example

```{r, echo=FALSE, message=FALSE,warning=FALSE}
library(gapminder)
library(plotly)
p <- gapminder %>%
  plot_ly(
    x = ~gdpPercap, 
    y = ~lifeExp, 
    size = ~pop, 
    color = ~continent, 
    frame = ~year, 
    text = ~country, 
    hoverinfo = "text",
    type = 'scatter',
    mode = 'markers'
  ) %>%
  layout(
    xaxis = list(
      type = "log"
    )
  )
p
```

## Referencias
