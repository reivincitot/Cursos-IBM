library(ggplot2)
#-------------Bar charts
qplot(
  mtcars$cyl,
  geom = "bar",
  fill = I("blue"),
  xlab = "Cylinders",
  ylab = "Number of Vehicles",
  main = "Cylinders in mtcars"
)

#---------------


#--------------Pie Charts

barp <- ggplot(mtcars, aes(x=1, y=sort(carb), fill=sort(carb))) + 
  geom_bar(stat="identity")

barp <- barp + coord_polar(theta = 'y')
barp <- barp + theme(
  axis.line = element_blank(),
  axis.text.x = element_blank(),
  axis.text.y = element_blank(),
  axis.ticks = element_blank(),
  axis.title.y = element_blank(),
  panel.background = element_blank()) + labs(y="Carburetors")
print(barp)

#-----------------------------------------------------------------
ggplot(data=mtcars,aes(x=mpg, y=wt)) +
  geom_point(shape=1)
############## dependiendo de los valores cambiara la forma de los puntos en el scatterplot
mtcars$cylFactor <- factor(mtcars$cyl)

ggplot(data = mtcars, aes(x=mpg,y=wt, shape= cylFactor)) +
  geom_point()
############## dependiendo de los valores cambiara de color de los puntos en el scatter plot
ggplot(data = mtcars , aes(x=mpg, y= wt, color=cylFactor)) +
  geom_point()
##########
ggplot(data = mtcars, aes(x=mpg,y=wt, shape=cylFactor)) +
  geom_point() +
  labs(title= "Scatterplot", x="Miles per Gallon", y="Weight")
############
ggplot(data=mtcars, aes(x=mpg,y=wt,color=cylFactor)) +
  geom_point(shape=19) +
  labs(title="Scatterplot", x="Miles per Gallon", y="Weight", colour="Cylinders")
