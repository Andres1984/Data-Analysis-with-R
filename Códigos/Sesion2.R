## Sesión 2#####


## Universidad Central
## Curso de Verano 2019

rm(list=ls())

##########################################################
#############   Jueves 27 de Junio 2019   ################
#############   Andrés Martínez           ################
#############   Departamento de Economía  ################
##########################################################

options(java.parameters = "-Xmx3000m")
#Sys.setem(JAVA_HOME="C:\\Program Files (x86)\\Java\\jre.8.0_101")
## Contenido

# Ubicando dirección URL
# Tipos de Archivos
# Libreria dplyr
# Bases de datos variables categóricas
# Bases de datos Numéricas

## Ubicando Dirección URL


library(RCurl)# La dirección web
library(readr)# La base de datos en cvs o txt

text=getURL("https://raw.githubusercontent.com/Andres1984/Data-Analysis-with-R/master/Bases/SPlista.txt")

#Archivo txt 
SPlista <- read_csv(file=text)
head(SPlista)
unique(SPlista$Sector)

SPlista$Sector[SPlista$Sector=="Consumer Discretionary"]="Cons D"
SPlista$Sector[SPlista$Sector=="Information Technology"]="IT"
SPlista$Sector[SPlista$Sector=="Telecommunications Services"]="TS"
SPlista$Sector[SPlista$Sector=="Consumer Staples"]="Cons S"
attach(SPlista)
unique(Sector)
fabs<-table(Sector)
fabs=as.data.frame(fabs)
n=dim(SPlista)
n<-n[1]
## Transformación bases de datos con dplyr
library(dplyr)
fabs= mutate(fabs, Freqr =fabs$Freq/n)
fabs= mutate(fabs, FreqA =cumsum(Freq))
fabs= mutate(fabs, FreqrA =cumsum(Freqr))


barplot(fabs$Freqr*100,col = "wheat",names.arg = fabs$Sector,ylab="Freq Rel %")
title("Sectores")

detach(SPlista)

#Archivo en excel
library(readxl)
library(httr)# Otra forma de encontrar direcciones 
library(psych)
library(dplyr)
url1<-'https://raw.githubusercontent.com/Andres1984/Data-Analysis-with-R/master/Bases/Matriculados_2017.xlsx'
GET(url1, write_disk(tf <- tempfile(fileext = ".xlsx"))) 
df <- read_excel(tf)
View(df)
columnas=df[6,]

df<-df[-1:-6,]
colnames(df)=columnas
str(df)
head(df)
tail(df)
unique(df$`Nivel Académico`)
unique(df$`Programa Académico`)
unique(df$`Nivel de Formación`)
resumen=as.data.frame( describe(df))
class(df$`Programa Académico`)
class(df$`Matriculados 2017`)

ftable<- as.data.frame(table(df$`Nivel Académico`))

colnames(df)[4]="Principal"

colnames(df)[9]="Código"
colnames(df)[16]="Nivel"
colnames(df)[18]="Formación"
colnames(df)[14]="Programa"


df1=filter(df, Principal ==  "PRINCIPAL" & Código == "11" & Nivel == "PREGRADO" & Formación=="Universitaria") %>%
  as.data.frame

unique(df1$Programa)



library(stringr)


df2=df1 %>% 
  filter(str_detect(Programa, "ECONOM")) 


df3<- df1 %>% 
  filter(str_detect(Programa, "ADMINISTRAC"))

df4<- df1 %>% 
  filter(str_detect(Programa, "CONTADUR"))

df5<-rbind(df2,df3,df4)

unique(df5$Programa)

library(xlsx)
resultado=write.xlsx(df5,"/Users/andresmartinez/Google Drive/Ucentral/InteR/Data-Analisys with R/Bases/Resultado.xlsx")

## Eliminar todo lo que no sea turístico usando !   filter(!str_detect(rowname, "\\d"))
##


library(readxl)
library(httr)# Otra forma de encontrar direcciones 
url1<-'https://raw.githubusercontent.com/Andres1984/Data-Analysis-with-R/master/Bases/DatosVAR.xlsx'
GET(url1, write_disk(tf <- tempfile(fileext = ".xlsx"))) 
Datos <- read_excel(tf)


par(mfrow=c(2,2),mar=c(2,2,2,2))
plot(Datos$Dates,Datos$COP, type="l",col="green",main = "COP",xlab="Dates",ylab="Prices")
plot(Datos$Dates,Datos$BRL,type="l",col="red",main="BRL",xlab="Dates",ylab="Prices")
plot(Datos$Dates,Datos$ARS,type="l",col="blue",main="ARS",xlab="Dates",ylab="Prices")
plot(Datos$Dates,Datos$MXN,type="l",main="MXN",xlab="Dates",ylab="Prices")

library(quantmod)
rend=as.data.frame( cbind(Delt(Datos$COP),Delt(Datos$BRL),Delt(Datos$ARS),Delt(Datos$MXN),Delt(Datos$CO1),Delt(Datos$CL1)))
rend=rend[-1,]
colnames(rend)=c("COP","BRL","ARS","MXN","BRENT","WTI")

par(mfrow=c(2,2),mar=c(2,2,2,2))
plot(rend$COP, type="l",col="green",main = "COP",xlab="",ylab="Returns")
plot(rend$BRL,type="l",col="red",main="BRL",xlab="",ylab="Returns")
plot(rend$ARS,type="l",col="blue",main="ARS",xlab="",ylab="Returns")
plot(rend$MXN,type="l",main="MXN",xlab="",ylab="Returns")



resumen=as.data.frame(describe(rend*100))

par(mfrow=c(2,2),mar=c(2,2,2,2))

hist(as.numeric(rend$COP),breaks=20,main="COP",xlab="Rendimientos COP", col="red")
hist(as.numeric(rend$BRL),breaks=20,main="BRL",xlab="Rendimientos BRL", col="green")
hist(as.numeric(rend$ARS),breaks=20,main="ARS",xlab="Rendimientos ARS", col="yellow")
hist(as.numeric(rend$MXN),breaks=20,main="MXN",xlab="Rendimientos MXN", col="blue")


library(RCurl)# La dirección web
library(readr)# La base de datos en cvs o txt

text=getURL("https://raw.githubusercontent.com/Andres1984/Data-Analysis-with-R/master/Bases/2016.csv")

H2016 <- read_csv(file=text)

# https://www.kaggle.com/unsdsn/world-happiness
summary(H2016)


x <- H2016$`Economy (GDP per Capita)`
y <- H2016$`Happiness Score`

plot(x, y, main = "HSCRO VS GDP",
     xlab = "GDP", ylab = "H SCORE",
     pch = 19, frame = FALSE)
# Add regression line
plot(x, y, main = "HSCRO VS GDP",
     xlab = "GDP", ylab = "H SCORE",
     pch = 19, frame = FALSE)
abline(lm( `Happiness Score` ~ `Economy (GDP per Capita)`, data = H2016), col = "blue")


plot(H2016$`Economy (GDP per Capita)`, H2016$`Happiness Score`, col = "green", pch = 3, 
     main = "R Scatter Plot", 
     xlab = "H Score", 
     ylab = "GDP", 
     las = 1,
     xlim = c(0, 10), 
     ylim = c(0, 10))
abline(lm( `Happiness Score` ~ `Economy (GDP per Capita)`, data = H2016), col = "blue")


plot(H2016$`Economy (GDP per Capita)`, H2016$`Happiness Score`, col = "green", pch = 3, 
     main = "R Scatter Plot", 
     xlab = "H Score", 
     ylab = "GDP", 
     las = 1,
     xlim = c(0, 2), 
     ylim = c(0, 10))
abline(lm( `Happiness Score` ~ `Economy (GDP per Capita)`, data = H2016), col = "blue")

library("car")
scatterplot(`Happiness Score` ~ `Economy (GDP per Capita)`, data = H2016, col = "blue")
scatterplot(`Happiness Score` ~ `Health (Life Expectancy)`, data = H2016, col = "blue")
qqPlot(H2016$`Happiness Score`)
hist(H2016$`Happiness Score`,breaks=20,main="HScore", col="red")

