 # econ589univariateGarch.r
#
# R examples for lectures on univariate GARCH models
#
# Eric Zivot
# April 2nd, 2012
# update history
# May 14, 2013
#   Changed "compound" to "log" in CalculateReturns()
# April 17, 2013
#   Updated examples for spring 2013 class
# April 19, 2012
#   Added GARCH estimation and forecasting

# load libraries
library(PerformanceAnalytics)
library(quantmod)
library(rugarch)
library(car)
library(MTS)

options(digits=4)
#


# download data
symbol.vec = c("MSFT", "^GSPC")
getSymbols(symbol.vec, from ="2015-01-03", to = "2019-03-03")
colnames(MSFT)
start(MSFT)
end(MSFT)

# extract adjusted closing prices
#MSFT = MSFT[, "MSFT.Adjusted", drop=F]
#GSPC = GSPC[, "GSPC.Adjusted", drop=F]

# plot prices
plot(MSFT$MSFT.Adjusted)
plot(GSPC$GSPC.Adjusted)

# calculate log-returns for GARCH analysis
MSFT.ret = CalculateReturns(MSFT$MSFT.Adjusted, method="log")
GSPC.ret = CalculateReturns(GSPC$GSPC.Adjusted, method="log")


# remove first NA observation
MSFT.ret = MSFT.ret[-1,]
GSPC.ret = GSPC.ret[-1,]
colnames(MSFT.ret) ="MSFT"
colnames(GSPC.ret) = "GSPC"

# create combined data series
MSFT.GSPC.ret = cbind(MSFT.ret,GSPC.ret)

# plot returns
plot(MSFT.ret)
plot(GSPC.ret)

# plot returns with squared and absolute returns
dataToPlot = cbind(MSFT.ret, MSFT.ret^2, abs(MSFT.ret))
colnames(dataToPlot) = c("Returns", "Returns^2", "abs(Returns)")
plot.zoo(dataToPlot, main="MSFT Daily Returns", col="blue")

dataToPlot = cbind(GSPC.ret, GSPC.ret^2, abs(GSPC.ret))
colnames(dataToPlot) = c("Returns", "Returns^2", "abs(Returns)")
plot.zoo(dataToPlot, main="GSPC Daily Returns", col="blue")

# plot autocorrelations of returns, returns^2 and abs(returns)

par(mfrow=c(3,2))
acf(MSFT.ret, main="MSFT Returns")
acf(GSPC.ret, main="GSPC Returns")
acf(MSFT.ret^2, main="MSFT Returns^2")
acf(GSPC.ret^2, main="GSPC Returns^2")
acf(abs(MSFT.ret), main="MSFT abs(Returns)")
acf(abs(GSPC.ret), main="GSPC abs(Returns)")
par(mfrow=c(1,1)) 

# compute summary statistics
table.Stats(MSFT.GSPC.ret)

#
# simulate ARCH(1) process
#

# use rugarch function ugarchsim
?ugarchspec
?ugarchpath

# specify arch(1) model
arch1.spec = ugarchspec(variance.model = list(garchOrder=c(1,0)), 
                        mean.model = list(armaOrder=c(0,0)),
                        fixed.pars=list(mu = 0, omega=0.1, alpha1=0.8))
class(arch1.spec)
arch1.spec

set.seed(123)
arch1.sim = ugarchpath(arch1.spec, n.sim=1000)
# result is an S4 object
class(arch1.sim)
# [1] "uGARCHpath"
# attr(,"package")
# [1] "rugarch"
slotNames(arch1.sim)
# [1] "path"  "model" "seed"
names(arch1.sim@path)
# [1] "sigmaSim"  "seriesSim" "residSim" 

# use the plot method to plot simulated series and conditional volatilities
par(mfrow=c(2,1))
plot(arch1.sim, which=2)
plot(arch1.sim, which=1)
par(mfrow=c(1,1))

par(mfrow=c(3,1))
acf(arch1.sim@path$seriesSim, main="Returns")
acf(arch1.sim@path$seriesSim^2, main="Returns^2")
acf(abs(arch1.sim@path$seriesSim), main="abs(Returns)")
par(mfrow=c(1,1))

# use qqPlot() function from car package
qqPlot(arch1.sim@path$seriesSim, ylab="ARCH(1) Returns")

#
# simulate GARCH(1,1) process
#

# specify GARCH(1,1) model
garch11.spec = ugarchspec(variance.model = list(garchOrder=c(1,1)), 
                          mean.model = list(armaOrder=c(0,0)),
                          fixed.pars=list(mu = 0, omega=0.1, alpha1=0.1,
                                          beta1 = 0.7))
set.seed(123)
garch11.sim = ugarchpath(garch11.spec, n.sim=1000)

# use the plot method to plot simulated series and conditional volatilities
win.graph(width=2.5,height=2.5,pointsize=8)
par(mfrow=c(2,1))
plot(garch11.sim, which=2)
plot(garch11.sim, which=1)
par(mfrow=c(1,1))

par(mfrow=c(3,1))
acf(garch11.sim@path$seriesSim, main="Returns")
acf(garch11.sim@path$seriesSim^2, main="Returns^2")
acf(abs(garch11.sim@path$seriesSim), main="abs(Returns)")
par(mfrow=c(1,1))

# use qqPlot() function from car package
qqPlot(garch11.sim@path$seriesSim, ylab="GARCH(1,1) Returns")

#
# Testing for ARCH/GARCH effects in returns
#
win.graph(width=2.5,height=2.5,pointsize=8)
# use Box.test from stats package
Box.test(coredata(MSFT.ret^2), type="Ljung-Box", lag = 12)
Box.test(coredata(GSPC.ret^2), type="Ljung-Box", lag = 12)

# use ArchTest() function from FinTS package for Engle's LM test
MSFTN=data.matrix(as.data.frame(MSFT.ret))

arch.test(MSFTN)
arch.test(GSPC.ret)


#
# Estimate GARCH(1,1)
#
# specify GARCH(1,1) model with only constant in mean equation
garch11.spec = ugarchspec(variance.model = list(garchOrder=c(1,1)), mean.model = list(armaOrder=c(0,0)))
MSFT.garch11.fit = ugarchfit(spec=garch11.spec, data=MSFT.ret,
                             solver.control=list(trace = 1))                          
class(MSFT.garch11.fit)
slotNames(MSFT.garch11.fit)
names(MSFT.garch11.fit@fit)
names(MSFT.garch11.fit@model)

# show garch fit
MSFT.garch11.fit

# use extractor functions

# estimated coefficients
coef(MSFT.garch11.fit)
# unconditional mean in mean equation
uncmean(MSFT.garch11.fit)
# unconditional variance: omega/(alpha1 + beta1)
uncvariance(MSFT.garch11.fit)
# persistence: alpha1 + beta1
persistence(MSFT.garch11.fit)
# half-life:
halflife(MSFT.garch11.fit)

# residuals: e(t)
plot.ts(residuals(MSFT.garch11.fit), ylab="e(t)", col="blue")
abline(h=0)

# sigma(t) = conditional volatility
plot.ts(sigma(MSFT.garch11.fit), ylab="sigma(t)", col="blue")
win.graph(width=2.5,height=2.5,pointsize=8)
# illustrate plot method
plot(MSFT.garch11.fit)
plot(MSFT.garch11.fit, which=1)
plot(MSFT.garch11.fit, which="all")
plot(MSFT.garch11.fit, which=9)
#
# simulate from fitted model
#

MSFT.garch11.sim = ugarchsim(MSFT.garch11.fit,
                             n.sim=nrow(MSFT.ret),
                             rseed=123,
                             startMethod="unconditional")
class(MSFT.garch11.sim)
slotNames(MSFT.garch11.sim)
win.graph(width=2.5,height=2.5,pointsize=8)
# plot actual returns and simulated returns
par(mfrow=c(2,1))
plot(MSFT.ret, main="Actual MSFT returns")
plot(as.xts(MSFT.garch11.sim@simulation$seriesSim, 
            order.by=index(MSFT.ret)),
     main="Simulated GARCH(1,1) Returns")
par(mfrow=c(1,1))

#
# fit ARCH(1) using "cleaned data"
#

# convergence problems with ARCH(1) fit to MSFT
arch1.spec = ugarchspec(variance.model = list(garchOrder=c(1,0)), 
                        mean.model = list(armaOrder=c(0,0)))
MSFT.arch1.fit = ugarchfit(spec=arch1.spec, data=MSFT.ret,
                           solver.control=list(trace = 1))

MSFT.ret.clean = Return.clean(MSFT.ret)
par(mfrow=c(2,1))
plot(MSFT.ret, main="Raw MSFT Returns", ylab="MSFT")
plot(MSFT.ret.clean, main="Cleaned MSFT Returns", ylab="MSFT")
par(mfrow=c(1,1))

MSFT.clean.arch1.fit = ugarchfit(spec=arch1.spec, data=MSFT.ret.clean,
                                 solver.control=list(trace = 1))
MSFT.clean.arch1.fit





#
# forecasting
#


MSFT.garch11.fcst = ugarchforecast(MSFT.garch11.fit, n.ahead=100,n.roll=0)
class(MSFT.garch11.fcst)
slotNames(MSFT.garch11.fcst)
names(MSFT.garch11.fcst@forecast)

MSFT.garch11.fcst
plot(MSFT.garch11.fcst)

par(mfrow=c(2,1))
plot(MSFT.garch11.fcst, which=1)
plot(MSFT.garch11.fcst, which=3)
par(mfrow=c(1,1))

#
#
# compute h-day variance forecast = sum of h-day ahead variance forecasts
#
class(MSFT.garch11.fcst@model$modeldata)
MSFT.garch11.fcst@
MSFT.fcst.df = as.data.frame(MSFT.garch11.fcst@model$modeldata)
MSFT.fcst.df<- data.frame(matrix(unlist(MSFT.garch11.fcst@model$modeldata), nrow=132, byrow=T),stringsAsFactors=FALSE)
head(MSFT.fcst.df)
# h-day return variance forecast = sum of h-day ahead variance forecasts
MSFT.fcst.var.hDay = cumsum(MSFT.garch11.fcst@model$modeldata$sigma^2)
MSFT.fcst.vol.hDay = sqrt(MSFT.fcst.var.hDay)

plot(MSFT.fcst.var.hDay,MSFT.fcst.vol.hDay, type="l",col="blue")

#
# computing VaR Forecasts
#


# h step-ahead conditional normal GARCH(1,1) VaR
VaR.95.garch11 = MSFT.fcst.df$series[1] + MSFT.fcst.df$sigma[1]*qnorm(0.05)
VaR.95.garch11

# compute 20-day vol forecast from fitted GARCH(1,1)
sigma.20day = sqrt(sum(MSFT.fcst.df$sigma[1:20]^2))
VaR.95.garch11.20day = 20*MSFT.fcst.df$series[1] + sigma.20day*qnorm(0.05)
VaR.95.garch11.20day



#
# bootstrap forecast densities
#

MSFT.garch11.boot = ugarchboot(MSFT.garch11.fit, method="Partial", 
                               n.ahead=100, n.bootpred=2000)
class(MSFT.garch11.boot)
MSFT.garch11.boot
plot(MSFT.garch11.boot)
#
# rolling estimation of GARCH(1,1)
#

MSFT.garch11.roll = ugarchroll(garch11.spec, MSFT.ret, n.ahead=1,
                               forecast.length = 1000,
                               refit.every=20, refit.window="moving")
class(MSFT.garch11.roll)

plot(MSFT.garch11.roll)
# VaR plot
plot(MSFT.garch11.roll, which=4)
# Coef plot`
plot(MSFT.garch11.roll, which=5)
# show backtesting report
?report
report(MSFT.garch11.roll, type="VaR")
report(MSFT.garch11.roll, type="fpm")



