## Sesión 3#####


## Universidad Central
## Curso de Verano 2019

rm(list=ls())

##########################################################
#############   Jueves 2 de Julio 2019   ################
#############   Andrés Martínez           ################
#############   Departamento de Economía  ################
##########################################################

## Contenido

# Libreria Quantmod y Apliación Quandl W
# Datos World Bank
# Libreria dplyr
# Bases de datos variables categóricas
# Bases de datos Numéricas

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
getSymbols(symbols,src='yahoo',from="2017-01-01",to="2019-03-01")

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

library(e1071) 


sesgo=aggregate(wb_dat[, 5:7], list(wb_dat$region), skewness,na.rm=TRUE)
Curtosis=aggregate(wb_dat[, 5:7], list(wb_dat$region), kurtosis,na.rm=TRUE)


library(plyr)

ddply(wb_dat,~region,summarise,mean=mean(GDP,na.rm=TRUE),sd=sd(GDP,na.rm=TRUE))

sgdp=describe.by(wb_dat[,5:7], wb_dat$region)
class(sgdp)

EAP=as.data.frame(sgdp$`East Asia & Pacific`)

library("gapminder")

data(gapminder)
str(gapminder)
dim(gapminder)
head(gapminder)

a=gapminder %>% 
  select(country, year, lifeExp, gdpPercap)

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
  scale_x_log10()+transition_time(year)

