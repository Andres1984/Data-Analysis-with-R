date.start<-"2018-02-01"
date.end<-"2021-09-06"
library(quantmod)
library(dplyr)### merge
simbols=c("^GSPC","MSFT","AMZN","GOOG","AAPL")
getSymbols(simbols,src = "yahoo",from=date.start,to=date.end)
getSymbols("DGS1MO", src="FRED")
plot(DGS1MO)
TBILL=DGS1MO["2018::2020-09"]
plot(TBILL)

head(TBILL) ; tail(TBILL)

apply(is.na(TBILL),2,sum)

Assets=cbind(MSFT$MSFT.Close,AMZN$AMZN.Close,GOOG$GOOG.Close,AAPL$AAPL.Close,GSPC$GSPC.Close)

Assets<-merge(Assets, TBILL)

dim(Assets)
head(Assets)
tail(Assets)
apply(is.na(Assets),2,sum)## Número de valores perdidos


index.notNA.SP500<-which(is.na(coredata(Assets$GSPC.Close))==FALSE)
Assets<-Assets[index.notNA.SP500,]

head(Assets)
tail(Assets)

apply(is.na(Assets)==TRUE, 2,sum)

Assets<-na.locf(Assets)

apply(is.na(Assets),2,sum) 



dim(Assets)
head(Assets)
tail(Assets)
colnames(Assets)=c("MSFT","AMZN","GOOG","AAPL","^GSPC","TBILL")



plot(Assets[,"MSFT"],ylab="Price",main="MSFT")

plot(Assets[,"^GSPC"], ylab="Value",main="S&P500 Index")

plot(Assets[,"TBILL"], ylab="Rate" ,
     main="1-Month Treasury Rate (Constant Maturity)")


msft=Delt(Assets$MSFT)[-1]
amzn=Delt(Assets$AMZN)[-1]
goog=Delt(Assets$GOOG)[-1]
aapl=Delt(Assets$AAPL)[-1]
sp=Delt(Assets$`^GSPC`)[-1]


rend=cbind(sp,msft,amzn,goog,aapl)
colnames(rend)=c("^GSPC","MSFT","AMZN","GOOG","AAPL")

muhat.vals = as.data.frame(colMeans(rend))# Media de los retornos
rownames(muhat.vals)=c("^GSPC","MSFT","AMZN","GOOG","AAPL")
cov.mat = var(rend)# Matriz de varianza y covarianza

## Calculo del Beta y el alpha forma rapida

beta.vals = cov.mat[,1]/cov.mat[1,1]
alpha.vals = muhat.vals[-1,] - beta.vals[-1]*muhat.vals[1,1] #Primera forma de calcularlo
beta.vals
alpha.vals*20



tbill<-(1+Assets$TBILL/100)^(1/250)-1## Los datos diarios
tbill=tbill[-1]

# Calcular los excesos de retorno (over riskfree rate)

ermsft<-msft-tbill
eramzn<-amzn-tbill
ergoog<-goog-tbill
eraapl<-aapl-tbill
ersp<-sp-tbill

errend=cbind(ersp,ermsft,eramzn,ergoog,eraapl)
colnames(errend)=c("^GSPC","MSFT","AMZN","GOOG","AAPL")
#Now we plot the excess returns of MSFT vs those of the SP500:

plot(as.numeric(ersp), as.numeric(ermsft),pch=16, col="cyan2",xlab="S&P",ylab = "MSFT")
abline(h=0,v=0)

plot(rnorm(100), rnorm(100),pch=16, col="cyan2",xlab="S&P",ylab = "MSFT")
abline(h=0,v=0)



# Generando un primer CAPM para MSFT

#The linear regression model is fit using the R-function lm():

options(show.signif.stars=TRUE) 

capmmsft<-lm(ermsft ~ ersp)# Ecuación 11

summary.lm(capmmsft) #function summarizing objects created by lm()


capmmsft.summary<-summary(capmmsft)
tstat.intercept<-round(capmmsft.summary$coefficients["(Intercept)", "t value"],digits=4)




# Re-Plot data adding
#     fitted regression line
#     selective highlighting of influential cases

plot(as.numeric(ersp), as.numeric(ermsft),
     main="MSFT vs SP500", cex.main=0.8,pch=16, col="cadetblue4")
abline(h=0,v=0)
abline(capmmsft, col="darkblue", lwd=3)
abline(a=alpha.vals["MSFT"], b=beta.vals["MSFT"],
       col="orange", lwd=3)


# Generando un primer CAPM para AMZN


capmamzn<-lm(eramzn ~ ersp)
summary.lm(capmamzn) #function summarizing objects created by lm()


capmamzn.summary<-summary(capmamzn)
tstat.intercept<-round(capmamzn.summary$coefficients["(Intercept)", "t value"],digits=4)

plot(as.numeric(ersp), as.numeric(amzn),
     main="AMZN vs SP500", pch=16,col="cadetblue4" )
abline(h=0,v=0)
abline(capmamzn, col=3, lwd=3)
abline(a=alpha.vals["AMZN"], b=beta.vals["AMZN"],
       col="orange", lwd=3)

# Portafolio dos acciones
mu.A = mean(msft)*20# Promedio de rentabilidad MSFT
mu.B = mean(amzn)*20# Promedio de rentabilidad de AMZN
sdmsft=sd(rend$MSFT)*sqrt(20)
sdamzn=sd(rend$AMZN)*sqrt(20)





betamsft=capmmsft$coefficients[2]
betaamzn=capmamzn$coefficients[2]
beta=c(betamsft,betaamzn)
names(beta)=c("MSFT","AMZN")
x.A = seq(from=-0.4, to=1.4, by=0.1)# Pesos de MSFT
x.B = 1 - x.A # Pesos de AMZN
mu.p = x.A*mu.A + x.B*mu.B
sigmap=sqrt(x.A^2*sdmsft^2+x.B^2*sdamzn^2+2*0.72*sdmsft*sdamzn*x.A*x.B)

betap=x.A*betamsft+x.B*betaamzn##### Beta que ya obtuve lo multiplico por el peso de cada poratolio
betap
### Indice de treynor
r=(1+(0.12/100))^(1/12)-1
BIT=(mu.p-r)/betap### Calculo el índice de Treynor
T=(mu.B-r)/betaamzn
betap
