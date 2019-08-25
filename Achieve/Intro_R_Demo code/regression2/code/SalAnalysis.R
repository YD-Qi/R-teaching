#####################################################
#####################################################
##
##   Session Setup
##
#####################################################
#####################################################

library(faraway)      # glm support
library(MASS)         # negative binomial support
library(car)          # regression functions
library(lme4)         # random effects
library(ggplot2)      # plotting commands
library(reshape2)     # wide to tall reshaping
library(xtable)       # nice table formating
library(knitr)        # kable table formating
library(grid)         # units function for ggplot



saveDir <- getwd()    # get the current working directory
saveDir               # show me the saved directory

wd <- "u:/RFR"        # path to my project
# setwd(wd)           # set this path as my work directory


#######################################################
#######################################################
##
##   Import Data
##
#######################################################
#######################################################

SalariesIn <- read.table("Datasets/Salaries.csv", 
                          sep=",",header=TRUE)
SalariesIn <- read.table("Datasets/Salaries.txt" ) 


str(SalariesIn)


SalariesIn$yrs.service        # yrs.service variable
SalariesIn[2,]                # second row, observation
SalariesIn$discipline[6]      # 6th observation of the discipline variable
SalariesIn[5,"yrs.service"]   # row 5 of the yrs.service variable
SalariesIn[4,3]               # row 4, column 3
SalariesIn[2:6,]              # observations 2 through 6
SalariesIn[c(7,9,16),]        # observations 7, 9, and 16


sum( is.na(SalariesIn) )
sum( SalariesIn=="" )

salary <- SalariesIn

salary$salary <- salary$salary / 1000
logSalary <- log(salary$salary)
 

salaryLevel = ifelse(salary$salary>134, "high",
 ifelse(salary$salary<91, "low","middle"
 ) )
 salaryLevel2 = cut(salary$salary,c(0,91,134,Inf),
 labels=c("low","middle","high")
 )
sum( salaryLevel != salaryLevel2 )
salary$salary[ which( salaryLevel != salaryLevel2 ) ]


salary$salary[ which( salaryLevel != salaryLevel2 ) ]


str(salaryLevel)


salary <- data.frame(salary,
 logSalary = logSalary,
 salaryLevels = factor(salaryLevel)
)
colnames(salary) <- c("rank","dscpl","yrSin","yrSer","sex",
                      "salary","logSal","salLev")
str(salary)


#######################################################
#######################################################
##
##   Data exploration
##
#######################################################
#######################################################

summary(salary)

# salary$rank <- ordered(salary$rank, levels=c("AsstProf","AssocProf","Prof"))
salary$rank <- factor(salary$rank, levels=c("AsstProf","AssocProf","Prof"))

salaryNum <- salary

for (i in colnames(salary)) {
  salaryNum[,i] <- as.numeric(salary[,i])
}

round( cor(salaryNum[,-c(8)]), 3)

table(salary$rank,salary$dscpl,salary$sex) 

aggregate(salary$salary, 
          by=list(rank=salary$rank,
                  dscpl=salary$dscpl,
                  gender=salary$sex
          ),
          FUN=length
)

ggplot(data=salary, aes(x=yrSer, y=salary)) +
  geom_point() +
  theme_bw() +
  ggtitle("Professor's salaries from 2008-9") 

ggplot(data=salary, aes(x=yrSer, y=salary)) +
  geom_point() +
  theme_bw() +
  ggtitle("Professor's salaries from 2008-9") +
  theme( plot.title=element_text(vjust=1.0) ) +
  xlab("Years of service") +
  theme( axis.title.x = element_text(vjust=-.5) ) +
  ylab("Salary in thousands of dollars") +
  theme( axis.title.y = element_text(vjust=1.0) ) 

plotSalFacRank <- ggplot(data=salary, aes(x=yrSer, y=salary)) +
  geom_point() +
  theme_bw() +
  ggtitle("Professor's salaries from 2008-9") +
  theme( plot.title=element_text(vjust=1.0) ) +
  xlab("Years of service") +
  theme( axis.title.x = element_text(vjust=-.5) ) +
  ylab("Salary in thousands of dollars") +
  theme( axis.title.y = element_text(vjust=1.0) ) +
  facet_wrap(~rank) +
  theme(strip.background = element_rect(fill = "White"))
plotSalFacRank

ggplot(data=salary, aes(x=yrSer, y=salary)) +
  geom_point(aes(color=rank)) +
  theme_bw() +
  ggtitle("Professor's salaries from 2008-9") +
  theme( plot.title=element_text(vjust=1.0) ) +
  xlab("Years of service") +
  theme( axis.title.x = element_text(vjust=-.5) ) +
  ylab("Salary in thousands of dollars") +
  theme( axis.title.y = element_text(vjust=1.0) ) +
  theme(legend.position = "bottom")

plot( salary[,-c(8)] )

