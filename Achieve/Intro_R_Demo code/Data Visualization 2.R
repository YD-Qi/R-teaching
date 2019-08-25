#Data Visualization 2

library(ggplot2)
qplot(Wind, Temp, data=airquality, color=Month)

qplot(Wind, Temp, data=airquality, color=I("red"))
qplot(Wind, Temp, data=airquality, shape=Month)
qplot(Wind, Temp, data=airquality, size=Month)
qplot(Wind, Temp, data=airquality, size=I(1))

qplot(Wind, Temp, data=airquality, size=I(1),
      xlab="wind (mph)", ylab="Temp",
      main="wind vs. temp")

qplot(Wind, Temp, data=airquality, 
      geom = c("point", "smooth"))

qplot(Wind, Temp, data=airquality,color=Month, 
      geom = c("point", "smooth"))

qplot(Wind, Temp, data=airquality,
      facets = .~Month)

qplot(Wind, Temp, data=airquality,
      facets = Month~.)

qplot(Wind, data=airquality)

qplot(Wind, data=airquality,
      facets = Month~.)

qplot(y=Wind, data=airquality)

qplot(Wind, data=airquality, fill=Month)

qplot(Wind, data=airquality, geom="density")

qplot(Wind, data=airquality, geom="density",
      color=Month)

qplot(Wind, data=airquality, geom="dotplot")
