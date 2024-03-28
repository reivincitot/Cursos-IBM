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