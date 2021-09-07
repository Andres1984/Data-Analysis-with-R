


library(psych)
describe(Default)





library(ggplot2)
library(tidyverse)
# Regression model
pd<- glm( default ~ student, data=Default, family=binomial)
a=predict(pd, type="response")
a=as.data.frame(a)
a=cbind(a,Default$student)
plot(a$`Default$student`,a$a,type="l", main="Probabilidad de Default", xlab="Estudiante",ylab="P(X)")
newdata[, c("p", "se")] <- predict(pd, newdata, type = "response", se.fit = TRUE)[-3]
# Get predictions on link scale
pred =predict(pd, Default, se.fit=TRUE, type="response")[c("fit", "se.fit")]
pred=as.data.frame(pred)
# Calculate fit and confidence interval on probability scale
pred$upr = pd$family$linkinv(pred$fit + 1.96*pred$se.fit)  # Equivalent to pnorm(pred$fit + 1.96*pred$se.fit) for the probit link
pred$lwr = pd$family$linkinv(pred$fit - 1.96*pred$se.fit)
pred$fit = pd$family$linkinv(pred$fit)




pd<- glm( default ~ balance, data=Default, family=binomial)
y=seq(0,3000,0.25)[-1]
sup=exp(pd$coefficients[1]+pd$coefficients[2]*y)
inf=1+exp(pd$coefficients[1]+pd$coefficients[2]*y)
px=sup/inf
result=as.data.frame(cbind(y,px))
colnames(result)=c("Balance","PX")
plot(result$Balance,result$PX,type="l", main="Probabilidad de Default", xlab="Balance",ylab="P(X)",ylim = c(0,1))
abline(h=c(0,1))




pd<- glm( default ~ balance+ student + income, data=Default, family=binomial)
summary(pd)
y=seq(0,3000,0.25)[-1]
sup=exp(pd$coefficients[1]+pd$coefficients[2]*y)
inf=1+exp(pd$coefficients[1]+pd$coefficients[2]*y)
px=sup/inf
result=as.data.frame(cbind(y,px))
colnames(result)=c("Balance","PX")
plot(result$Balance,result$PX,type="l", main="Probabilidad de Default", xlab="Balance",ylab="P(X)",ylim = c(0,1))
abline(h=c(0,1))




glm.probs=predict(pd,type = "response")
glm.pred=rep("No",10000)
glm.pred[glm.probs>.5]="Yes"
table(glm.pred,Default$default) 

