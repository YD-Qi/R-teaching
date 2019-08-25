#. 描述性统计：Summary statistics 
#计算基本统计值及其作图
#○ 均值：Mean
#○ 中位数：Median
#○ 标准差：Standard Deviation
set.seed(123)
x<-rnorm(100000)
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
