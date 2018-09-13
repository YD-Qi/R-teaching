################################
# Created by Chris Qi
# Last time modified: 02/21/2018
#Copy right reserved
################################

# Regression Analysis 线性回归分析

# 1. 读取数据，做基本观察
cars<-mtcars
names(cars)
str(cars)
head(cars)
tail(cars)
summary(cars)
# 2. 对感兴趣的变量做进一步观察，异常值
scatter.smooth(x=cars$mpg, y=cars$wt, main="mpg ~ wt")
par(mfrow=c(1, 2))  # divide graph area in 2 columns
boxplot(cars$mpg, main="Speed", sub=paste("Outlier rows: ", boxplot.stats(cars$mpg)$out))  # box plot for 'speed'
boxplot(cars$wt, main="Distance", sub=paste("Outlier rows: ", boxplot.stats(cars$wt)$out))  # box plot for 'distance'

# 3. 线性回归
linearMod <- lm(mpg ~ wt, data=cars)  # build linear regression model on full data
summary(linearMod)

# 4. 小试一下，所谓机器学习
### 首先将数据随机分组成训练用的和测试用的 -------------------------------------------------------
set.seed(100) # setting seed to reproduce results of random sampling
trainingRowIndex <- sample(1:nrow(cars), 0.8*nrow(cars)) # row incices for training data
trainingData <- cars[trainingRowIndex, ] # model training data
testData <- cars[-trainingRowIndex, ] # test data

### 然后，用训练数据建立一个模型----------------------------------------------------
lmMod <- lm(mpg ~ wt, data=trainingData) # build the model
### 再然后，将我们建立的模型用来测试数据上，做预测
mpgPred <- predict(lmMod, testData) # predict distance

###检验一下，我们的预测效果
actuals_preds <- data.frame(cbind(actuals=testData$mpg, predicteds=mpgPred)) # make actuals_predicteds dataframe.
attach(actuals_preds)
correlation_accuracy <- cor(actuals,predicteds) 
correlation_accuracy


###########################################################
###经济学家将你如何成为优秀的品酒师

# 1. 读取数据，做基本观察
wine = read.csv("wine.csv") 
head(wine)
str(wine)
summary(wine$Year)
cor(wine)
round(cor(wine), 2)
wineReordered = wine[c("Price", "Year", "WinterRain", "AGST", "HarvestRain", "Age", "FrancePop")] 
round(cor(wineReordered), 2)

# 2. 建立多个模型，比较优劣，谁的解释力高（R平方大）
model1 = lm(Price ~ AGST, data = wine) 
model1
summary(model1)

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
predictTest = predict(model3, newdata = wineTest) 
predictTest
SSE = sum((wineTest$Price - predictTest)^2) 
SST = sum((wineTest$Price - mean(wine$Price))^2) 
1 - SSE/SST




