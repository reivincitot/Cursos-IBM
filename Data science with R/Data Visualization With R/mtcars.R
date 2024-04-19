library(ggplot2)
library(tm)
library(wordcloud)
library(ggradar)
library(dplyr)
library(scales)
library(ggradar)
library(waffle)
library(plotly)
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


#--------------------------  line plots

EuStockDF <- as.data.frame(EuStockMarkets)

head(EuStockDF)

ggplot(EuStockDF,aes(x=c(1:nrow(EuStockDF)),y = DAX)) + geom_line()

#--------------------word cloud

dir.create("E:/Cursos-IBM/Data science with R/Data Visualization With R/Modulo 3 Specialized Visualization Tools/word cloud/wordcloud")
download.file("https://ibm.box.com/shared/static/cmid70rpa7xe4ocitcga1bve7r0kqnia.txt",
              destfile="E:/Cursos-IBM/Data science with R/Data Visualization With R/Modulo 3 Specialized Visualization Tools/wordcloud/churchill_speeches.txt",quiet=TRUE)

# seleccionar carpeta
#dirPath <- "E:/Cursos-IBM/Data science with R/Data Visualization With R/Modulo 3 Specialized Visualization Tools/wordcloud"

# Cargar la información como un cuerpo
speech <- Corpus(DirSource(dirPath))

inspect(speech)

# word cloud data cleaning

#standarization of word
speech <- tm_map(speech, content_transformer(tolower))

# removing numbers
speech <- tm_map(speech,removeNumbers)

# removing common stop words
speech <- tm_map(speech, removeWords,
                 stopwords("english"))

# removing you own stop words  by specifying the word in the caracter vector

speech <- tm_map(speech, removeWords,
                c("floccionacinihilipification", "squirrelled"))

# remove punctuation
speech <- tm_map(speech, removePunctuation)

# remove unnecesary whitespace
speech <- tm_map(speech,stripWhitespace)

# Paso 2 Crear un Term document Matrix

# Create a term documbent matrix
dtm <- TermDocumentMatrix(speech)

# Matrix Transformation

m <- as.matrix(dtm)

# sort it to show the most frequent word

v <- sort(rowSums(m), decreasing = TRUE)

# transform to a data frame

d <- data.frame(word = names(v),freq=v)
head(d,10)


# paso 3 simple word cloud

wordcloud(words = d$word,freq = d$freq)

# frecuancia
wordcloud(words = d$word, freq = d$freq,
          min.freq = 1)

wordcloud(words = d$word, freq =  d$freq,
          min.freq = 1, max.words = 250)

#radar charts
#Selecet our dataset
mtcars %>%
  #atribute row names to a variable
  add_rownames(var = "group") %>%
  #assign each variable - car names -- to their related variables
  mutate_each(funs(rescale),-group) %>%
  # select wich data to plot
  head(3) %>% select(1:10) -> mtcars_radar

options(warn = 1)
ggradar(mtcars_radar)

# para modificar el tamaño del gráfico de radar usamos
IRKernel::Set_plot_options(width=950, height=600, units='px')
ggradar(mtcars_radar)

#waffle chart
#implementación en R
expenses <- c("Health ($43,212)"= 43212,
              "Education ($113,412)"=113412,
              "Transportation ($20,231)"=20231,
              "Entertainment ($28,145)"=28145) 


waffle(expenses/1235, row=5, size=0.3,
       colors=c("#c7d4b6","#a3aabd","#a0d0de","#97b5cf"),
       title="Imaginary Household Expenses Each Year",
       xlab="1 square= $934")

# para modificar el tamaño del gráfico usaremos
IRKernel::set_plot_options(width=959, height=600, units="px")
waffle(expenses/1235, row=5, size=0.3,
       colors=c("#c7d4b6","#a3aabd","#a0d0de","#97b5cf"),
       title="Imaginary Household Expenses Each Year",
       xlab="1 square= $934")
# boxplots

# haciendo que los resultados sean reproducibles
set.seed(1234)

set_a<- rnorm(200, mean=1,sd=2)
set_b<- rnorm(200,mean=0, sd=1)
# creamos el dataframe
df <- data.frame(label=factor(rep(c("A","B"),each=200)),value=c(set_a,set_b))

head(df)
tail(df)

#geom_boxplot()
ggplot(df,aes(x=label,y=value)) + geom_boxplot()

ggpplotly()

#boxplot usando qplot()
qplot(factor(cyl),mpg,data=mtcars,geom="boxplot")

cars <- ggplot(mtcars,aes(factor(cyl),mpg))
cars+geom_boxplot()
