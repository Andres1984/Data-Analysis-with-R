library(ggplot2)
library(ISLR)



ggplot(Default,aes(x=default,fill=student))+
  geom_bar()

ggplot(Default,aes(x=balance,fill=default))+
  geom_histogram()

ggplot(Default,aes(x=balance,fill=default))+
  geom_density()

ggplot(Default,aes(x=balance,y=income,col=default))+
  geom_point()


# Regression model
pd<- glm( default ~ student, data=Default, family=binomial)
a=predict(pd, type="response")
a=as.data.frame(a)
a=cbind(a,Default$student)


ggplot(a,aes(`Default$student`,a))+
  geom_point()+
  labs(x = "Student",y="Probabilidad")
newdata <- predict(pd, type = "response", se.fit = TRUE)[-3]


pd<- glm( default ~ balance, data=Default, family=binomial)
y=seq(0,3000,0.25)[-1]
sup=exp(pd$coefficients[1]+pd$coefficients[2]*y)
inf=1+exp(pd$coefficients[1]+pd$coefficients[2]*y)
px=sup/inf
result=as.data.frame(cbind(y,px))
colnames(result)=c("Balance","PX")
plot(result$Balance,result$PX,type="l", main="Probabilidad de Default", xlab="Balance",ylab="P(X)",ylim = c(0,1))
abline(h=c(0,1))


ggplot(result,aes(Balance,PX))+
  geom_line()+
  geom_abline(result,aes(Balance[6000], px[6000]))+
  labs(x = "Balance",y="Probabilidad")
