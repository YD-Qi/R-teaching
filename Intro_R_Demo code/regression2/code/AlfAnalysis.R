#######################################################
#######################################################
##
##   alfalfa solution code for Data Prep
##
#######################################################
#######################################################



#######################################################
#######################################################
##
##   Environment Setup
##
#######################################################
#######################################################

library(faraway)      # glm support
library(MASS)         # negative binomial support
library(car)          # regression functions
library(lme4)         # random effects
library(ggplot2)      # plotting commands
library(reshape2)     # wide to tall reshaping
library(xtable)       # nice table formatting
library(knitr)        # kable table formatting
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

alfalfaIn <- read.table("Datasets/alfalfa.txt", header=TRUE)
str(alfalfaIn)
alfalfa <- alfalfaIn

#
# change the column names to "shade","irrig",
#   "inoc", and "yield"
#

colnames(alfalfa) <- c("shade","irrig","inoc","yield")

#
# create a new variable for shade level (shadeLev)
#   set 1 to "full", 5 to "none", and the rest to "part"
#

shadeLev <- cut(alfalfa$shade,c(0,1.5,4.5,6),
                labels=c("full","part","none")
                )

#
# change the type of shade level to factor
#

shadeLev <- factor(shadeLev)

#
# include shadeLev in the alfalfa data.frame
#

alfalfa <- data.frame(alfalfa,
                      shadeLev=shadeLev
                      )

#
# change inoculum E to control
#

alfalfa$inoc <- ifelse(alfalfa$inoc=="E","cntrl",
                       as.character(alfalfaIn$inoculum)
)
alfalfa$inoc <- factor(alfalfa$inoc)


str(alfalfa)



#######################################################
#######################################################
##
##   alfalfa solution code for Data Exploration
##
#######################################################
#######################################################


#######################################################
#######################################################
##
##   Data explortion
##
#######################################################
#######################################################

summary(alfalfa)

cor(alfalfa[,-c(3,5)])    

table(alfalfa$shade,alfalfa$irrig)

aggregate(alfalfa$yield, by=list(alfalfa$inoc),FUN=mean)

plot(alfalfa)

ggplot(alfalfa) +
  geom_point(aes(x=inoc, y=yield, color=shade)) +
  theme_bw()




