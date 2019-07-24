## Sesión 1#####




rm(list=ls())

##########################################################
#############   Martes 25 de Junio 2019   ################
#############   Andrés Martínez           ################
#############                             ################
##########################################################

## Contenido

# Comandos Básicos
# Vectores
# Matrices
# Objetos
# Loops and Statements
# Funciones 
# Gráficos

### Comandos básicos de R

2+2
x<-2
y<-3
z<-x+y

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
class(x)
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



### Matrices 

m <- matrix(1:6, nrow = 2, ncol = 3) 
m
dim(m)

x <- 1:3
y <- 10:12
cbind(x, y)
rbind(x, y)


x=seq(1:9)
x
X<-dat <- matrix(x, nrow = 3, ncol = 3, byrow = TRUE,
                 dimnames = list(c("row1", "row2","row3"),
                                 c("C.1", "C.2", "C.3")))
X
det(X)
inv(X)


y=runif(9)

Y<-dat <- matrix(y, nrow = 3, ncol = 3, byrow = TRUE,
                 dimnames = list(c("row1", "row2","row3"),
                                 c("C.1", "C.2", "C.3")))
Y

Z=X+Y
Z
det(Z)
library(pracma)
O=inv(Z)
O
I=diag(3)
I
T=Z%*%O
T

## Objetos

# List

x <- list(1, "a", TRUE, 1 + 4i) 
x

L1 <- list(c(1,2,3,4,5), matrix(1:8,2), c('some', 'easy', 'strings'))
L2 <- list(study = 'statistics', SKZ = 875)
list(5, c(3, 4, 5), c("A", "Hoolahoop"))
L3 <- list(a=5, g=c(3, 4, 5), c=c("A", "Hoolahoop"), d=list(hui=23, pfui=24))
L3
names(L3)
L3$g
L3[[3]]
L3[c(1,3)]
L1[[3]][2]
L1[[c(3, 2)]]
L3[[c(4, 2)]]


# Factor

x <- factor(c("yes", "yes", "no", "yes", "no")) >
x

fish <- c("salmon", "bass", "salmon", "salmon", "shark", "bass", "shark", "salmon")
fishf <- factor(fish)
fishf
levels(fishf)
table(fishf)

## Valores Perdidos

x <- c(1, 2, NA, 10, 3)

is.na(x)
is.nan(x)

x <- c(1, 2, NaN, NA, 4)
is.na(x)
is.nan(x)

x <- data.frame(foo = 1:4, bar = c(T, T, F, F)) 
x


# Operadores Lógicos

lVec <- 1:30
lVec > 21
lVec == 12
lVec >= 5
c(TRUE, TRUE) & c(FALSE, TRUE)
c(TRUE, TRUE) && c(FALSE, TRUE)
c(TRUE, TRUE) | c(FALSE, TRUE)
lVec <- c(1:10, 1:10)
any(lVec > 11)
which(lVec > 6)

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
x
y <- rep(0,n)
for( i in 1:n ){
  y[i] <- log(x[i]) 
}
y


# Genere un cálculo cualquiera mil veces

# if 

x <- 5
if(x > 0){
  print("Non-negative number")
} else {
  print("Negative number")
}

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
  
  print(VR)
}


sqrt(2)
2^3
log(10)
exp(10)
log(exp(1))

rnorm(2)
rnorm(2)
set.seed(1234)
rnorm(2)
set.seed(1234)
rnorm(2)

1:10%%6
1:10%/%6
x <- 1:20
x%%6==0


# Add 6 to all numbers which are divisible by 6
x[x%%6==0] <- x[x%%6==0] + 6
x <- 1:20
?ifelse
ifelse(x%%6==0, x+6, x)
as.logical(x%%6)
ifelse(x%%6, x, x+6)
ifelse(!x%%6, x+6, x)


# Coneciones lógicas
z <- rnorm(100)
z > -1 & z < 1
sum(z > -1 & z < 1)
set.seed(1234)
z > -1 & z < 1
sum(z > -1 & z < 1)
z1 <- rnorm(100)
all(z==z1)
any(z==z1)

3>2
3>=2
1:5<4
1:5<=4
1:5==4
1:5!=4
!1:5==4
!(1:5==4)
!-3:3
as.logical(-3:3)
x<- -3:3
!x
x

# factors
# Categorial variables are called factors
sex <- sample(1:2,10,replace=TRUE)
sex
sex <- factor(sex,1:2,c("m","w"))
sex
str(sex)
table(sex)
summary(sex)
factor(sample(1:3,10,replace=TRUE),1:3,c("bad","okay","good"),ordered=FALSE)
factor(sample(1:3,10,replace=TRUE),1:3,c("bad","okay","good"),ordered=TRUE)


# data frames
# Dataframes are specific lists which includes characters and numbers. Characters are automatically transformed to numbers if matrices are generated.

cbind(age=rnorm(10,45),sex=sex)
list(age=rnorm(10,45),sex=sex)

# Construction of dataframes
df <- data.frame(age=rnorm(10,45),sex=sex)
df[1,]
df$age
df[df$age>45,]
subset(df,age>45)



