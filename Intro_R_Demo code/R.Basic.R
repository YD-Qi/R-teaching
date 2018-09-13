#实际操作：
##############################
#1. 使用R: Using 
#R表达式，变量，函数的简介
#○ 表达式：Expressions
1+2
"Hello world!"
6*7+6^2+sqrt(9)

#○ 逻辑值：Logical Values
2+3==5
F==FALSE
#○ 变量：Variables
x<-10
x*2
x<-"hello world!"
x<-FALSE

#○ 函数：Functions
sum(2,4,6)
rep("hi",times=3)

#○ 查看帮助：Help 
help(sum)
example(sum)
help(rep)
#○ 文件：Files
list.files()


##############################
#2. 向量：Vectors
#将数值组合成向量，并进行计算和作图
#○ 向量：Vectors
c(2,4,8)
c("jack","jackie","jessica")
c(1,TRUE,"dog")

#○ 序列向量：Sequence vectors
4:8
seq(4,8)
seq(4,8,0.5)
9:5

#○ 提取向量中的元素：Vector access
words<-c('lets','go','fishing')
words[2]
words[4]<-'boy'
words
words[c(1,3)]
words[2:4]

#○ 向量命名：Vector names
ranking<-1:4
names(ranking)<-c("gold","silver","bronze","nothing")
ranking
ranking["silver"]
ranking["nothing"]<-5

#○ 单一向量作图：Plotting one vector
score<-c(60,90,80)
barplot(score)
names(score)<-c("jack","jackie","jassica")
barplot(score)
barplot(-50:50)
#○ 向量计算：Vector math
a<-c(0,45,30)
a+1
a/3
a*3
b<-c(3,5,2)
a+b
a==c(1,3,7)
a<c(1,3,7)
cos(a)
sqrt(a)

#○ 散点图：Scatter plots
x<-seq(2,10,0.2)
y<-sin(x)
plot(x,y)

c<--5:5
absolutes<-abs(c)
plot(c,absolutes)

#○ 缺失值处理：NA values
d<-c(3,5,7,NA)
mean(d)
?mean
mean(d,na.rm=T)
##############################
#3. 矩阵：Matrices
#二维数据生成以及作图
#○ Matrices
matrix(0,3,3)
a<-1:9
a
matrix(a,3,3)
something<-1:16
dim(something)<-c(4,4)
something

matrix(6,3,3)
#○ Matrix access
something[2,3]
something[2,3]<-0
something
something[1,]
something[,2]
something[,2:3]

#○ Matrix plotting
elevation<-matrix(2,15,15)
elevation[5,6]<-1
contour(elevation)
persp(elevation)
persp(elevation,expand=0.2)

contour(volcano)
persp(volcano,expand=0.2)
image(volcano)

##############################
#4. 描述性统计：Summary statistics 
#计算基本统计值及其作图
#○ 均值：Mean
#○ 中位数：Median
#○ 标准差：Standard Deviation
set.seed(123)
x<-rnorm(1000)
mean(x)
sd(x)
median(x)

hist(x) #直方图，频率 
hist(x,pro=T) #直方图，概率

lines(density(x)) #加一条正态分布曲线
lines(density(x), col="blue") #曲线改成蓝色
lines(density(x), col="blue",lw=3) #曲线加粗
mx<-mean(x)
abline(v = mx, col = "red", lwd = 2) #加一条红色直线代表均值
SD<-sd(x)
abline(v = mx + SD, col = "red", lwd = 2)
abline(v = mx - SD, col = "red", lwd = 2)

##############################
#5. 因子：Factors
#生成分类数据及其作图
#○ 生成因子：Creating factors
bins <- c('gold', 'silver', 'gems', 'gold', 'gems')
types <- factor(bins)
bins
types
as.integer(types)
levels(types)

#○ 用因子作图：Plots with factors
weights <- c(300, 200, 100, 250, 150)
prices <- c(9000, 5000, 12000, 7500, 18000)
plot(weights, prices)

plot(weights, prices, pch=as.integer(types))
legend("topright", c("gems", "gold", "silver"), pch=1:3)
legend("topright", levels(types), pch=1:length(levels(types)))

##############################
#6. 数据框：Data frames
#将数值组织成数据框，读取文件中的数据合并数据
#○ 数据框：Data frames
treasure <- data.frame(weights, prices, types)

#○ 提取数据框中的元素：Data frame access
treasure[[2]]
treasure[["weights"]]
treasure$prices
treasure[["types"]]

##############################
#7. 真实世界的数据：Real-World Data
#○ 读取数据：Loading data frames
list.files()
#read.table("infantry.txt", sep="\t", header=TRUE)
myWine<-read.csv("wine.csv")
#基本描述性统计
ls(myWine)
summary(myWine)
summary(myWine$Price)
mean(myWine$Price)
sd(myWine$Price)
#箱图
boxplot(myWine$Price)

#创建新变量
myWine$surveyYear<-myWine$Year+myWine$Age

#散点图
plot(myWine$Price,myWine$Age)

#相关性检验，p值小于0.05，可以称为在统计上显著
cor.test(myWine$Price,myWine$Age)

#线性模型
line <- lm(myWine$Price~myWine$Age)
line
abline(line)

##############################
#作图一瞥：ggplots2
#扩展包
install.packages("ggplot2")
qplot(weights, prices, color = types)

##############################
#存储数据
write.csv(myWine,'ourWine.csv') #存为csv格式，方便转化为excel
save.image(file = "ourWine.RData") #Rdata,R数据标准格式
load("ourWine.RData") #读取R数据标准格式

################################
#8.移除对象
rm()
rm(list=ls())
ls()
