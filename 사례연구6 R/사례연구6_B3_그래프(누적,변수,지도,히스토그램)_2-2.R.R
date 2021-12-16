#누적 막대차트####



data("VADeaths")
VADeaths


str(VADeaths)
class(VADeaths)
mode(VADeaths)
v<-data.frame(VADeaths)

library(plotly)




v1<-as.numeric(v[1,])
v2<-as.numeric(v[2,])
v3<-as.numeric(v[3,])
v4<-as.numeric(v[4,])
v5<-as.numeric(v[5,])
class(names(v))
fig <- plot_ly(v, x = ~names(v), y =~v1, type = 'bar', name = '50~54')
fig <- fig %>% add_trace(y = ~v2, name = '55-59')
fig <- fig %>% add_trace(y = ~v3, name = '60-64')
fig <- fig %>% add_trace(y = ~v4, name = '65-69')
fig <- fig %>% add_trace(y = ~v5, name = '70-74')
fig <- fig %>% layout(yaxis = list(title = 'Count'), barmode = 'stack')
fig


#히스토그램####
library(plotly)
library(gridExtra)
library(grid)
data('iris')
head(iris)
fig <- plot_ly(x = ~iris$Sepal.Length, type = "histogram");fig

#변수간비교 ####



df<-iris

axis = list(showline=FALSE,
            zeroline=FALSE,
            gridcolor='#ffff',
            ticklen=4)

fig <- df %>%
  plot_ly() 
fig <- fig %>%
  add_trace(
    type = 'splom',
    dimensions = list(
      list(label='sepal length', values=~Sepal.Length),
      list(label='sepal width', values=~Sepal.Width),
      list(label='petal length', values=~Petal.Length),
      list(label='petal width', values=~Petal.Width)
    ),
    text=~class,
    marker = list(
      color = as.integer(df$class),
      colorscale = pl_colorscale,
      size = 7,
      line = list(
        width = 1,
        color = 'rgb(230,230,230)'
      )
    )
  ) 
fig <- fig %>%
  layout(
    title= 'Iris Data set',
    hovermode='closest',
    dragmode= 'select',
    plot_bgcolor='rgba(240,240,240, 0.95)',
    xaxis=list(domain=NULL, showline=F, zeroline=F, gridcolor='#ffff', ticklen=4),
    yaxis=list(domain=NULL, showline=F, zeroline=F, gridcolor='#ffff', ticklen=4),
    xaxis2=axis,
    xaxis3=axis,
    xaxis4=axis,
    yaxis2=axis,
    yaxis3=axis,
    yaxis4=axis
  )

fig


























#지도시각화####

library(plotly)

setwd('c:/Rwork/dataset3/dataset3/')

us_cities = read.csv('population201901.csv')

fig <- us_cities 
fig <- fig %>%
  plot_ly(
    lat = ~LAT,
    lon = ~LON,
    marker = list(color = "fuchsia"),
    type = 'scattermapbox',
    hovertext = us_cities[,"지역명"]) 
fig <- fig %>%
  layout(
    mapbox = list(
      style = 'open-street-map',
      zoom =5,
      center = list(lon = 128, lat = 36))) 
fig <- fig %>%
  test

fig
#############################################################

