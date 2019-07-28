## Sesión 3#####


## Universidad Central
## Curso de Verano 2019

rm(list=ls())

##########################################################
#############   Jueves 2 de Julio 2019    ################
#############   Andrés Martínez           ################
#############   Departamento de Economía  ################
##########################################################

## Contenido
# Lapply Sapply tapply mapply split
# Libreria Quantmod y Apliación Quandl W
# Datos World Bank
# Libreria dplyr
# Bases de datos variables categóricas
# Bases de datos Numéricas


## lapply Lapply Sapply tapply mapply split

lapply
x <- list(a = 1:5, b = rnorm(10))
lapply(x, mean)

x <- list(a = 1:4, b = rnorm(10), c = rnorm(20, 1), d = rnorm(100, 5))
lapply(x, mean)

x <- 1:4
lapply(x, runif)


x <- 1:4
lapply(x, runif, min = 0, max = 10)


x <- list(a = matrix(1:4, 2, 2), b = matrix(1:6, 3, 2)) 
x

function(elt) { elt[, 1] }

lapply(x, function(elt) { elt[,1] })

lapply(x, f)

x <- list(a = 1:4, b = rnorm(10), c = rnorm(20, 1), d = rnorm(100, 5)) 
lapply(x, mean)


sapply
sapply(x, mean)

str(split)

x <- c(rnorm(10), runif(10), rnorm(10, 1)) 
f <- gl(3, 10)


split(x, f)


lapply(split(x, f), mean)

library(datasets) 
head(airquality)

s <- split(airquality, airquality$Month)


lapply(s, function(x) {
  
  colMeans(x[, c("Ozone", "Solar.R", "Wind")]) 
  })


sapply(s, function(x) {
  colMeans(x[, c("Ozone", "Solar.R", "Wind")]) 
  })


sapply(s, function(x) {
  colMeans(x[, c("Ozone", "Solar.R", "Wind")], 
           na.rm = TRUE)
   })

x <- rnorm(10) 
  f1 <- gl(2, 5) # Factor levels
f2 <- gl(5, 2) 
f1
f2

str(split(x, list(f1, f2)))
str(split(x, list(f1, f2), drop = TRUE))

str(tapply)
x <- c(rnorm(10), runif(10), rnorm(10, 1)) 
## Define some groups with a factor variable 
f <- gl(3, 10)

f
tapply(x, f, mean)
tapply(x, f, mean, simplify = FALSE)
tapply(x, f, range)


str(apply)

x <- matrix(rnorm(200), 20, 10)
apply(x, 2, mean)

apply(x, 1, sum)

apply(x, 2, sum)

apply(x, 1, mean)

x <- matrix(rnorm(200), 20, 10)
apply(x, 1, quantile, probs = c(0.25, 0.75))

a <- array(rnorm(2 * 2 * 10), c(2, 2, 10)) 
apply(a, c(1, 2), mean)

rowMeans(a, dims = 2) ## Faster

str(mapply)

mapply(rep, 1:4, 4:1)

list(rep(1, 4), rep(2, 3), rep(3, 2), rep(4, 1))

noise <- function(n, mean, sd) { 
  rnorm(n, mean, sd)
  }

# Un conjunto de números
noise(5, 1, 2)
# Un conjunto de números
noise(1:5, 1:5, 2)
# Cinco conjuntos de números
mapply(noise, 1:5, 1:5, 2)





##Quandl
library(Quandl)

wheat=Quandl("CHRIS/MGEX_MW4", api_key="zxdSEzha_e_UwhD8Pgdw")
class(wheat)

# NROUT Tasa natural de desempleo USA
NROUT=Quandl("FRED/NROUST", api_key="zxdSEzha_e_UwhD8Pgdw")
# Crecimiento doméstico potencial USA
GPD=Quandl("FRED/GDPPOT", api_key="zxdSEzha_e_UwhD8Pgdw")


# National Average Income hasta 2015 PSE Paris School of Economics

TOGO=Quandl("PSE/ANNINC992I_PALL_TG", api_key="zxdSEzha_e_UwhD8Pgdw")
TONGA=Quandl("PSE/AGDPRO992I_PALL_TO", api_key="zxdSEzha_e_UwhD8Pgdw")
library(dplyr)
africa=merge(TOGO, TONGA, by.x="Date", by.y="Date")
colnames(africa)=c("Date","TOGO","TONGA")
africa=merge(africa,wheat, by.x="Date", by.y="Date")
africa1=merge(TOGO, TONGA, by.x="Date", by.y="Date",all=TRUE)
africa1=merge(TOGO, TONGA, by.x="Date", by.y="Date")
africa1=merge(africa,wheat, by.x="Date", by.y="Date",all=TRUE)

## Quantmod
library(quantmod)
symbols=c('AES','AXP','BXP','GLW')# Vector de caracteres
getSymbols(symbols,src='yahoo',from="2017-01-01",to="2019-07-01")

dim(AES)
class(AES)
plot(AES$AES.Close)
barChart(AES$AES.Close)
candleChart(AES,multi.col=TRUE,theme="white") 
candleChart(AES[500:542,],theme="white") 
chartSeries(AES) 
addMACD() 
addBBands() 


getSymbols(c("UNRATE", "FEDFUNDS","CPIAUCSL","M1SL","GDPDEF","GDP","TB3MS"), src="FRED")




# 3 Variables
ymat0<-merge(UNRATE, FEDFUNDS, CPIAUCSL)
ind.quarterly0<-1*(is.na(ymat0[,3])==FALSE)
sum(ind.quarterly0)
dim(ymat0)
ymat00<-ymat0[which(ind.quarterly0==1),]
head(ymat00)

ymat00.0<-window(ymat00,start = as.Date("1960-01-01"), end = as.Date("2018-12-31"))
dim(ymat00.0)
head(ymat00.0)
acf(ymat00.0, lag.max=10)
acf(ymat00.0, type="partial", lag.max=10)

## World Bank

library(wbstats)
new_wb_cache <- wbcache() 

wbsearch("gdp.*capita.*US\\$", cache = new_wb_cache)

wbsearch("life expectancy at birth.*total", cache = new_wb_cache)
wbsearch("^mortality.*rate.*infant", cache = new_wb_cache)

wbsearch("Agriculture", cache = new_wb_cache)
AG=as.data.frame(wbsearch("Agriculture", cache = new_wb_cache))
View(AG)



wb_dat <- wb(indicator = c("NY.GDP.PCAP.KD", "SP.DYN.LE00.IN", "SP.DYN.IMRT.IN")) 
names(wb_dat)

#Limpieza de Datos

wb_countries <- wbcountries() 
names(wb_countries)
wb_dat <- merge(wb_dat, y = wb_countries[c("iso2c", "region")], by = "iso2c", all.x = TRUE)

wb_dat <- subset(wb_dat, region != "Aggregates") # Remover NA


#Renombrar Observación

wb_dat$indicatorID[wb_dat$indicatorID == "NY.GDP.PCAP.KD"] <- "GDP"
wb_dat$indicatorID[wb_dat$indicatorID == "SP.DYN.LE00.IN"] <- "life_expectancy"
wb_dat$indicatorID[wb_dat$indicatorID == "SP.DYN.IMRT.IN"] <- "infant_mortality"

library(reshape2)
wb_dat <- dcast(wb_dat, iso2c + country + date + region ~ indicatorID,  value.var = 'value')

resumen=as.data.frame(describe(wb_dat))

media_r=aggregate(wb_dat, list(wb_dat$region), mean)

media_r=aggregate(wb_dat, list(wb_dat$region), mean, na.rm=TRUE )
media=aggregate(wb_dat[, 5:7], list(wb_dat$region), mean,na.rm=TRUE)
class(media)
desest=aggregate(wb_dat[, 5:7], list(wb_dat$region), sd,na.rm=TRUE)
var=aggregate(wb_dat[, 5:7], list(wb_dat$region), var,na.rm=TRUE)
mini=aggregate(wb_dat[, 5:7], list(wb_dat$region), min,na.rm=TRUE)
maxi=aggregate(wb_dat[, 5:7], list(wb_dat$region), max,na.rm=TRUE)

tapply(wb_dat$infant_mortality, wb_dat$region, mean, na.rm=TRUE)
tapply(wb_dat$infant_mortality, wb_dat$country, mean, na.rm=TRUE)
Summary=tapply(wb_dat$infant_mortality, wb_dat$country, summary, na.rm=TRUE)

media=aggregate(infant_mortality  ~ region, wb_dat, mean )
mediac=aggregate(infant_mortality  ~ country, wb_dat, mean )


mean(wb_dat$infant_mortality)
mean(wb_dat$infant_mortality, na.rm = TRUE)
sd(wb_dat$infant_mortality,na.rm=TRUE)
tapply(wb_dat$infant_mortality, wb_dat$region, mean)
tapply(wb_dat$infant_mortality, wb_dat$region, mean, na.rm=TRUE)
tapply(wb_dat$infant_mortality, wb_dat$country, mean, na.rm=TRUE)
Summary=tapply(wb_dat$infant_mortality, wb_dat$country, summary, na.rm=TRUE)

media=aggregate(infant_mortality  ~ region, wb_dat, mean )
mediac=aggregate(infant_mortality  ~ country, wb_dat, mean )
View(media)
View(mediac)

ResumenR=tapply(wb_dat$infant_mortality, wb_dat$region, summary, na.rm=TRUE)
ResumenC=tapply(wb_dat$infant_mortality, wb_dat$country, summary, na.rm=TRUE)
View(ResumenR)
View(ResumenC)
ResumenR=as.data.frame(ResumenR)

Region=unique(wb_dat$region)
Region
class(Region)
ResumenR <- do.call(rbind,lapply(ResumenR,function(x) as.data.frame.list(lapply(x,as.data.frame.list))))

length(ResumenR)

ResumenR=matrix(ResumenR, nrow=7,ncol=7,byrow=TRUE)

ResumenR=as.data.frame(ResumenR)
colnames(ResumenR)=c("Min.","1st Qu.", "Median ","Mean","3rd Qu","Max","NA")

ResumenR=cbind(Region,ResumenR)


library(xlsx)
write.xlsx(ResumenR, "C:/Users/mmartinezp5/Dropbox/Estadistica 1 Eco/Codigos/ResumenR.xlsx") 





library(e1071) 


sesgo=aggregate(wb_dat[, 5:7], list(wb_dat$region), skewness,na.rm=TRUE)
Curtosis=aggregate(wb_dat[, 5:7], list(wb_dat$region), kurtosis,na.rm=TRUE)


library(plyr)

ddply(wb_dat,~region,summarise,mean=mean(GDP,na.rm=TRUE),sd=sd(GDP,na.rm=TRUE))

sgdp=describe.by(wb_dat[,5:7], wb_dat$region)
class(sgdp)

EAP=as.data.frame(sgdp$`East Asia & Pacific`)

library("gapminder")
library(dplyr)
data(gapminder)
str(gapminder)
dim(gapminder)
head(gapminder)


a=gapminder %>% 
  select(country, year, lifeExp, gdpPercap)
a
b=gapminder %>%
  filter(continent == "Americas")

c=gapminder %>%
  filter(country == "Colombia" | country == "Venezuela")


d=gapminder %>%
  select(country, year, gdpPercap) %>%
  filter(country %in% c("Germany", "Colombia", "Brazil", "Argentina") & year >= 2000)





# Fechas en R

x <- as.Date("1970-01-01")
x

unclass(as.Date("1970-01-02"))
x <- Sys.time()
x

class(x)

p <- as.POSIXlt(x)
names(unclass(p))


wheat$Date=as.Date(wheat$Date, format = "%d/%m/%Y")
class(wheat$Date)



# Hans Rosling Video https://www.youtube.com/watch?v=jbkSRLYSojo

library(gganimate)
library(gapminder)
library(ggplot2)

theme_set(theme_bw())
ggplot(gapminder,aes(gdpPercap,lifeExp,size=pop,color=continent))+
  geom_point()+
  scale_x_log10()+transition_time(year)+
  labs(title = "Year: {frame_time}")

