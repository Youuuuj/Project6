#사례연구6
#문현진
library(ggplot2)

#누적 막대차트xxx####
data("VADeaths")
VADeaths
mode(VADeaths)
v<-as.data.frame(VADeaths)
v
class(as.numeric(rownames(v)))
class(v$`Rural Male`)
as.numeric()
vt<-t(VADeaths)
vf<-as.factor(rownames(v))
vf
ggplot(diamonds,
       aes(x=clarity,
           fill=cut))+
  geom_bar()

ggplot(VADeaths,
       aes(x=names(v),
           fill=VADeaths[1,]))+
  geom_bar()



#######팀원 참고 자료
VADeaths_df <- as.data.frame(VADeaths)
str(VADeaths_df)
age <- c('50-54','55-59','60-64','65-69','70-74')
VADeaths_df <- cbind(VADeaths_df,age)


library(reshape2)
VAD_melt <- melt(VADeaths_df,
                 id.vars = 'age',
                 measure.var = c('Rural Male', 'Rural Female', 'Urban Male', 'Urban Female'))
VAD_melt# 


names(VAD_melt) <- c('age', 'location', 'deaths')
VAD_melt


ggplot(VAD_melt, aes(x = location, y = deaths, fill = age)) + 
  geom_bar(stat = 'identity', position = 'stack') + 
  labs(title = "미국 버지니아주 하위계층 사망비율") +
  theme(plot.title = element_text(hjust = 0.5)) 




#히스토그램####
data('iris')
head(iris)
iris[1]

ggplot(iris[1], aes(x=Sepal.Length, col='red')) +  geom_histogram()





#변수간 비교 시각화.####
############################################

#install.packages("GGally")
library(GGally) 
ggpairs(iris[,1:4])
############################################################
#또는
library(gridExtra)
library(grid)
library(ggplot2)
#library(lattice)
data(iris) 
p1 <- ggplot(data=iris,aes(x=Sepal.Length, y=Sepal.Length)) + geom_point()
p2 <- ggplot(data=iris,aes(x=Sepal.Length, y=Sepal.Width)) + geom_point()
p3 <- ggplot(data=iris,aes(x=Sepal.Length, y=Petal.Length)) + geom_point()
p4 <- ggplot(data=iris,aes(x=Sepal.Length, y=Petal.Width)) + geom_point()
p5 <- ggplot(data=iris,aes(x=Sepal.Length, y=Species)) + geom_point()
grid.arrange(p1, p2, p3, p4, p5, ncol=length(names(iris)))

############################################









#지도 시각화####
library(ggplot2)
#install.packages("ggmap")
library(ggmap)


setwd('c:/Rwork/dataset3/dataset3/')
pop <- read.csv('population201901.csv', header = T)
library(stringr)
region <- pop$'지역명'
lon <- pop$LON
lat <- pop$LAT
tot_pop <- as.numeric(str_replace_all(pop$'총인구수', ',', ''))
df <- data.frame(region, lon, lat, tot_pop)
df
df <- df[1:17, ]
df

daegu <- c(left = 123.4423013, bottom = 32.8528306,
           right = 131.601445, top = 38.8714354)
map <- get_stamenmap(daegu, zoom = 7, maptype = 'watercolor')

layer1 <- ggmap(map)
layer1

layer2 <- layer1 + geom_point(data = df, 
                              aes(x = lon, y = lat,
                                  color = factor(tot_pop), 
                                  size = factor(tot_pop)))
layer2

layer3 <- layer2 + geom_text(data = df, 
                             aes(x = lon + 0.01, y = lat + 0.08,
                                 label = region), size = 3)
layer3


#################################################################








                 