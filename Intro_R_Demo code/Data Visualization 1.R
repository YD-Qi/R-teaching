#Data Visualization 1: basics in R

hist(airquality$Wind)
hist(airquality$Wind, xlab = "wind")
boxplot(airquality$Wind)
boxplot(airquality$Wind, xlab="wind",ylab="Speed (mph)")
boxplot(Wind~Month,airquality,xlab="month", 
        ylab="speed (mph)")

plot(airquality$Wind,airquality$Temp)

with(airquality, plot(Wind, Temp))
title(main="wind and temp in NYC")

with(airquality, plot(Wind, Temp,
     main="wind and temp in NYC"))

with(airquality, plot(Wind, Temp,
                      main="wind and temp in NYC",
                      type = "n"))

with(subset(airquality, Month==9), 
     points(Wind, Temp, col="red"))
with(subset(airquality, Month==5), 
     points(Wind, Temp, col="blue"))
with(subset(airquality, Month==7), 
     points(Wind, Temp, col="green"))

with(subset(airquality, Month %in% c(6,8)), 
     points(Wind, Temp, col="black"))
fit<-lm(Temp~Wind, airquality)
abline(fit,lwd=2)

legend("topright", pch=1,
       col=c("red","blue","green","black"),
       legend=c("Sep","May","July","Other"))

par("bg")
par("col")
par("mar") #(bottom, left, top, right)
par("mfrow")
par("mfcol")
?par

par(mfrow = c(1,2))
hist(airquality$Temp)
hist(airquality$Wind)

boxplot(airquality$Wind)

par(mfrow = c(1,1))
boxplot(airquality$Wind)

par(mfcol = c(2,1))
hist(airquality$Temp)
hist(airquality$Wind)

#lattice 绘图实践
library(lattice)
xyplot(Temp~Ozone, data=airquality)
airquality$Month<-factor(airquality$Month)

xyplot(Temp~Ozone|Month, data=airquality,
       layout=c(5,1))

q<-xyplot(Temp~Ozone, data=airquality)
print(q)

set.seed(1)
x<-rnorm(100)
f<-rep(0:1, each=50)
y<-x + f - f*x + rnorm(100, sd=0.5)
f<-factor(f, labels = c("Group1", "Group2"))
xyplot(y~x|f,layout=c(2,1))

xyplot(y~x|f, panel = function(x,y){
  panel.xyplot(x,y)
  panel.abline(v=mean(x),h=mean(y), lty=2)
  panel.lmline(x,y,col="red")
})
