#葡萄酒品质预测入门版：
wine = read.csv("wine.csv") 
str(wine)

summary(wine)

cor(wine)
round(cor(wine), 2)
wineReordered = wine[c("Price", "Year", "WinterRain", "AGST", "HarvestRain", "Age", "FrancePop")] 
round(cor(wineReordered), 2)

#线性回归 
model1 = lm(Price ~ AGST, data = wine) 
model1
summary(model1)
ls(model1)
model1$residuals

model2 = lm(Price ~ AGST + HarvestRain, data = wine) 
summary(model2)

model3 = lm(Price ~ AGST + HarvestRain + WinterRain + Age + FrancePop, data = wine) 
summary(model3)

model4 = lm(Price ~ AGST + HarvestRain + WinterRain + Age, data = wine) 
summary(model4)


#读取需要预测的数据
wineTest = read.csv("wine_test.csv") 
str(wineTest)
#使用最佳模型进行预测
predictTest = predict(model4, newdata = wineTest) 
predictTest

SSE = sum((wineTest$Price - predictTest)^2) 
SST = sum((wineTest$Price - mean(wine$Price))^2) 
1 - SSE/SST

#葡萄酒品质高级进阶版：
whiteWine<-read.csv("whiteWine.csv")
attach(whiteWine)
ls(whiteWine)

par(mfrow=c(2,2))
hist(whiteWine$quality, prob=F, col="blue")
hist(fixed.acidity, prob=T, col="blue")
hist(volatile.acidity, prob=T, col="blue")
hist(citric.acid, prob=T, col="blue")
hist(residual.sugar, prob=T, col="blue")
hist(chlorides, prob=T, col="blue")

boxplot(fixed.acidity, col="slategray2", pch=19)
mtext("Fixed Acidity", cex=0.8, side=1, line=2)
boxplot(volatile.acidity, col="slategray2", pch=19)
mtext("Volatile Acidity", cex=0.8, side=1, line=2)
boxplot(citric.acid, col="slategray2", pch=19)
mtext("Citric Acid", cex=0.8, side=1, line=2)
boxplot(residual.sugar, col="slategray2", pch=19)
mtext("Residual Sugar", cex=0.8, side=1, line=2)
boxplot(chlorides, col="slategray2", pch=19)
mtext("Chlorides", cex=0.8, side=1, line=2)

install.packages("psych")

summary(whiteWine)
describe(whiteWine)
pairs(whiteWine[,-12], gap=0, pch=19, cex=0.4, col="darkblue")
title(sub="Scatterplot of Chemical Attributes", cex=0.8)

limout <- rep(0,11)
for (i in 1:11){
  t1 <- quantile(whiteWine[,i], 0.75)
  t2 <- IQR(whiteWine[,i], 0.75)
  limout[i] <- t1 + 1.5*t2
}
whiteWineIndex<- matrix(0, 4898, 11)
for (i in 1:4898)
  for (j in 1:11){
    if (whiteWine[i,j] > limout[j]) whiteWineIndex[i,j] <- 1
  }
WWInd <- apply(whiteWineIndex, 1, sum)
whiteWineTemp <- cbind(WWInd, whiteWine)
Indexes <- rep(0, 208)
j <- 1
for (i in 1:4898){
  if (WWInd[i] > 0) {Indexes[j]<- i
  j <- j + 1}
  else j <- j
}
whiteWineLib <-whiteWine[-Indexes,]   # Inside of Q3+1.5IQR
indexes = sample(1:nrow(whiteWineLib), size=0.5*nrow(whiteWineLib))
WWTrain50 <- whiteWineLib[indexes,]
WWTest50 <- whiteWineLib[-indexes,]