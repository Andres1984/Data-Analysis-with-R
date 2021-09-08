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
