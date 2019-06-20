## Sesión 1#####


## Universidad Central
## Curso de Verano 2019

rm(list=ls())

##########################################################
#############   Martes 25 de Junio 2019   ################
#############   Andrés Martínez           ################
#############   Departamento de Economía  ################
##########################################################

## Contenido

# Comandos Básicos
# Vectores
# Matrices
# Objetos
# Loops and Statements
# Funciones 
# Gráficos


### Paquetes
# paquetes instalados
library()

library("MASS")

help(package=MASS)

help(mean)
?mean
help.search("mean")
??mean

### Comandos básicos de R

2+2
x<-2
y<-3
z<-x+y

ls()
objects()

## remove object
rm(x)
ls()

## palabras reservadas
1 / 0
log(-3)
sqrt(-3)
sqrt(-3+0i)
naVec <- c(1, 2, 3, 4, NA, 5, 6, 7)
is.na(naVec)
is.null(NULL)
is.null(0)
is.nan(log(-3))


# Caracteres

str1 <- "R is useful"
str2 <- "but sometimes strange"
?substr
substr(str2, 5, 13)
substr(str2, 1, 3) <- "and"
?paste
paste(str1, str2)
paste(str1, str2, sep="")
paste(str1, str2, sep=", ")
?cat
cat(LETTERS, "\n")
cat(paste(1:50, "is an", c("odd", "even"), "number"), sep="\n")

#Vectores y elementos usuales del programa

c(2,3,5,6)
x<-c(2,3,5,6)
y<-c("A","B","C")
z<-c("A",3,"D")
class(x)
class(y)
class(z)

z<-as.list(z)
class(z)
x[1]
z<-x[1:2]+x[3:2]
z

msg <- "hello"


x <- c(0.5, 0.6)
x <- c(TRUE, FALSE)
x <- c(T, F)
x <- c("a", "b", "c") ## character 
x <- 9:29 ## integer 
x <- c(1+0i, 2+4i) ## complex
x <- vector("numeric", length = 10)
seq(-4, 1, 0.5)

y <- c(1.7, "a") ## character 
y <- c(TRUE, 2) ## numeric 
y <- c("a", TRUE) ## character

x <- 0:6
class(x)
 as.numeric(x)

as.logical(x)
as.character(x)

x <- c("a", "b", "c")
as.numeric(x)

as.logical(x)

as.complex(x)

1:30
30:1
zero100 <- rep(0, 100)
seq(0, 10, by=.5)
seq(-pi, pi, length=20)
seq(-pi, pi, by=.5)
zero2nine <- c(0, 1, 2, 3, 4, 5, 6, 7, 8, 9)

vec2 <- c(zero2nine, 10:12, c(20, 22, c(35, 31.2)))
names(vec2)

### Matrices 

m <- matrix(1:6, nrow = 2, ncol = 3) 
m
dim(m)

x <- 1:3
y <- 10:12
cbind(x, y)
rbind(x, y)



A <- matrix(1:20, 5, 4)
A
A[,3]
A[4,]
A[4, ,drop=FALSE]
A[3, 4]
A[3, 4, drop=FALSE]
t(A)
A[c(1, 3, 5), c(2, 4)]
cbind(A, 101:105)
rbind(A, c(0, 1))
rbind(A[c(1, 3, 5),], A[c(2, 4),])
A[c(1, 3, 5, 2, 4),]

## matrix dimensions
nrow(A)
ncol(A)
dim(A)
rownames(A) <- paste("row", 1:nrow(A))
colnames(A) <- paste("col", 1:ncol(A))
A
A['row3', 'col4']
A[, 'col2']
dim(A) <- c(10, 2)
A
dim(A) <- c(5, 4)

## vector-matrix operations
x <- c(1, 2, 0.5, 4)
mA <- matrix(1:16, 4, 4)
x %*% mA
mA %*% x
t(x) %*% mA
## mA %*% t(x) does not work

## outer and inner products
x %*% x
x %*% t(x)
t(x) %*% x

## linear algebra
mA2 <- matrix(c(34, 12, 12, 41), 2, 2)
solve(mA2)
Lt <- chol(mA2) ## returns L^T, i.e. upper triangular matrix
Lt              ## of Cholesky decomposition L * L^T
t(Lt) %*% Lt    ## see!
qr(A)
eigen(mA2)
eigen(mA2, only.values=TRUE)
svd(A)

## Objetos


#ARRAYS 

arrEx <- array(1:56, dim=c(7, 4, 2))
arrEx[1, 3, 2]
arrEx[,,2]
arrEx[,,2, drop=FALSE]
arrEx[,3,1]
arrEx[,3,1,drop=FALSE]
dimnames(arrEx) <- list(paste("A", 1:7), c("B1","B2","B3","B4"), c("C1","C2"))
dimnames(arrEx)
arrEx['A1', 'B3', 'C2']

is.array(A)
rownames(A) <- paste("row", 1:nrow(A), sep="")
colnames(A) <- paste("col", 1:ncol(A), sep="")
dimnames(A)
dimnames(A) <- list(c("A", "B", "C", "D", "E"), c("R", "S", "T", "U"))
A
B <- array(100:123, dim=c(6, 4))
B
is.matrix(B)
is.vector(array(1:5, dim=c(5)))
is.array(c(1, 2, 3, 4, 5))
as.vector(array(1:5, dim=c(5)))

T



# List

x <- list(1, "a", TRUE, 1 + 4i) 
x

# Factor

x <- factor(c("yes", "yes", "no", "yes", "no")) >
x


## Valores Perdidos

x <- c(1, 2, NA, 10, 3)
## Return a logical vector indicating which elements are NA >
is.na(x)
is.nan(x)

x <- c(1, 2, NaN, NA, 4)
is.na(x)
is.nan(x)

x <- data.frame(foo = 1:4, bar = c(T, T, F, F)) 
x


# Data frame

x <- c(3.1416,2.7183)
m <- matrix(rnorm(9),nrow=3)
tab <- data.frame(store=c("downtown","eastside","airport"),sales=c(32,17,24)) 
cities <- c("Seattle","Portland","San Francisco")
tab
tab$cities=cities
tab
## Loops and Statements




# for 
n=20
x<-rnorm(n,50,3)
y <- rep(0,n)
for( i in 1:n ){
  y[i] <- log(x[i]) 
}
y

for (i in seq(1, by=3, length=30)) {
  cat(i, "\n")
}

for (i in fishf) {
  cat(i, "is a fish\n")
}

for (i in L3) {
  cat("element has length", length(i), "\n")
}

n <- 10
for (i in 1:n) {
  cat(i, "\n")
}

n <- -2
for (i in 1:n) {
  cat(i, "\n")
}

# Genere un cálculo cualquiera mil veces

# if 

x <- -5
if(x > 0){
  print("Non-negative number")
} else {
  print("Negative number")
}

i <- 1
repeat {
  cat(i, "\n")
  i <- i + 1
  if (i > 20) {
    break
  }
}



dum <- 4 # play around with different values
if (dum == 4) {
  out <- "first block"
} else if (dum < 4) {
  out <- "second block"
} else {
  out <- "third block"
}
out

ifelse(1:20 %% 2, "odd", "even")
ifelse(A %% 2, "odd", "even")
ifelse(array(1:30, dim=c(2, 3, 5)), "odd", "even")


# Cree un Data Frame con dos vectores uno numérico y otro
# de caracterés que se repitan entre si, luego cree un vector
# aparte en donde si una letra se presenta es verdadero, de lo
# contrario falso


# While


i <- 1
while (i < 6) {
  print(i)
  i = i+1
}

while (i < 30) {
  cat(i, "\n")
  i <- i + 2
}

# switch


sel <- 4 # play around with different values
switch(sel, 2, 5, 7, 9, 10, 21)
switch("f", a=2, b=5, c=7, d=9, e=10, f=21, end=Inf)

## Funciones


VRC<-function(VF,i,n,VA){
  
  for(j in 1:length(VA+1)){
    if (VA>0 & VF>0){
      
      VR<- print("error solo puede aparecer un Valor mayor que cero")}
    
    else if(VA>0){
      
      VR<-VA*(1+i)^n}
    
    else if (VF>0){
      
      VR<-VF/(1+i)^n
    }
  } 
}

# Gráficos


data(airquality)
head(airquality)
str(airquality)
fivenum(airquality$Ozone)
summary(airquality)
library(psych)
describe(airquality)
resumen=as.data.frame(describe(airquality))

boxplot(airquality$Solar.R, col = "blue")

hist(airquality$Solar.R, col = "green")

hist(airquality$Solar.R, col = "green")
rug(airquality$Solar.R)

hist(airquality$Solar.R, col = "green", breaks = 20)



boxplot(airquality$Solar.R, col = "blue")
abline(h = 200)


hist(airquality$Solar.R, col = "green", breaks = 20)
abline(v = 120, lwd = 2)
abline(v = median(airquality$Solar.R), col = "magenta", lwd = 4)
abline(v = median(airquality$Solar.R, na.rm = TRUE ), col = "magenta", lwd = 4)


a=table(airquality$Wind) 
barplot(a,col = "wheat")

boxplot(Wind ~ Month, data = airquality, col = "red",ylab="Wind",xlab="Month")

boxplot(Ozone ~ Month, airquality, xlab = "Month", ylab = "Ozone (ppb)")
par(mfrow = c(2, 1), mar = c(4, 4, 2, 1)) 
hist(airquality$Solar.R, col = "green")
hist(airquality$Ozone, col = "green")

dev.off()
with(airquality, plot(Solar.R, Temp, col = Month, main="Scatter"))
abline(h = 12, lwd = 2, lty = 2)


with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in New York City", type = "n"))
with(subset(airquality, Month == 5), points(Wind, Ozone, col = "blue"))
with(subset(airquality, Month != 5), points(Wind, Ozone, col = "red"))
legend("topright", pch = 1, col = c("blue", "red"), legend = c("May", "Other Months"))


## Crear el gráfico de la siguiente función dentro de la función

VR<-function(VF,i,n,VA){
  
  
  
  for(j in 1:length(n+1)){
    if (VA>0 & VF>0){
      
      VR<- print("error solo puede aparecer un Valor mayor que cero")}
    
    else if(VA>0){
      
      VR<-VA*(1+i*n)}
    
    else if (VF>0){
      
      VR<-VF/(1+i*n)
    }
  } 
  
  

  
}
