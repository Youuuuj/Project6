# 유준

library(ggplot2)
library(plotly)
library(reshape2)
library(stringr)
library(UsingR)


# 3. 점 차트
# 데이터 만들기
chart_data <- c(305, 450, 320, 460, 330, 480, 380, 520)
names(chart_data) <- c("2018 1분기", "2019 1분기",
                       "2018 2분기", "2019 2분기", 
                       "2018 3분기", "2019 3분기", 
                       "2018 4분기", "2019 4분기")
str(chart_data)
head(chart_data)


# 데이터프레임으로 구조 변경
chart_df <- data.frame(연도 = c(2018, 2019, 2018, 2019, 2018, 2019, 2018, 2019),
                         분기 = c("1분기", "1분기",
                                "2분기", "2분기", 
                                "3분기", "3분기", 
                                "4분기", "4분기"),
                         매출액 = c(305, 450, 320, 460, 330, 480, 380, 520))

chart_df$연도 <- as.factor(chart_df$연도)
chart_df$매출액 <- as.numeric(chart_df$매출액)

str(chart_df)
head(chart_df)


# 시각화 PDF
dotchart(chart_data, color = c("blue", "red"),
         lcolor = "black", pch = 1:2,
         labels = names(chart_data),
         xlab = "매출액", 
         main = "분기별 판매현황: 점차트 시각화",
         cex = 1.2)

# 1) ggplot2 
ggplot(chart_df, aes(x = 매출액, y = 분기, fill = 연도)) + 
  geom_point(colour = 'grey', shape = 21, size = 6) + 
  labs(title = "분기별 판매현황: 점차트 시각화") +
  theme(plot.title = element_text(hjust = 0.5))

# 2) plotly - R.ver
Dot <- plot_ly(chart_df, x = ~매출액, y = ~분기, color = ~연도, type = 'scatter',
               marker = list(size = 10))
Dot <- Dot %>% layout(title = '분기별 판매현황: 점차트 시각화')
Dot


# 4. 원형차트

# 시각화 PDF
pie(chart_data, labels = names(chart_data), col = rainbow(8), cex = 1.2)
title("2018~2019년도 분기별 매출현황")


# 1) ggplot2
chart_df$기간 <-  c("2018년 1분기", "2019년 1분기",
                  "2018년 2분기", "2019년 2분기", 
                  "2018년 3분기", "2019년 3분기", 
                  "2018년 4분기", "2019년 4분기")

ggplot(chart_df, aes(x = '', y = 매출액, fill = 기간)) + 
  geom_bar(stat = 'identity', position = 'stack') + 
  theme_void()+
  coord_polar('y', start=0)+
  labs(title = "2018~2019년도 분기별 매출현황") +
  theme(plot.title = element_text(hjust = 0.5))


# 2) plotly - R.ver
Pie <- plot_ly(chart_df, labels = ~기간, values = ~매출액, type = 'pie')
Pie <- Pie %>% layout(title = '2018~2019년도 분기별 매출현황')
Pie




# 8. 중첩자료 시각화
data(galton)

galtonData <- as.data.frame(table(galton$child, galton$parent))
head(galtonData)

names(galtonData) = c("child", "parent", "freq")
head(galtonData)
parent <- as.numeric(galtonData$parent)
child <- as.numeric(galtonData$child)


# 시각화 PDF
plot(parent, child,
     pch = 21, col = "blue", bg = "green",
     cex = 0.2 * galtonData$freq,
     xlab = "parent", ylab = "child")


# 1) ggplot2 
qp <- data.frame(parent, child)
qp$freq <- galtonData$freq

ggplot(qp, aes(x = parent, y = child)) +
  geom_point(aes(size = freq), shape = 21, colour = 'grey',
             fill = 'purple', alpha = 0.5) +
  labs(title = "중첩자료 시각화") +
  theme(plot.title = element_text(hjust = 0.5))


# 2) plotly - R.ver
Bubble <- plot_ly(qp, x = ~parent, y = ~child, type = 'scatter', mode = 'markers',
                  marker = list(size = ~freq, opacity = 1.0, color = 'magenta'))
Bubble <- Bubble %>% layout(title = '중첩자료 시각화')
Bubble


# 10. 밀도 그래프
data(iris)

# 시각화 PDF
iris1 <- iris$Sepal.Width[iris$Species == 'setosa']
iris2 <- iris$Sepal.Width[iris$Species == 'versicolor']
iris3 <- iris$Sepal.Width[iris$Species == 'virginica']

str(iris2)

iris1_den <- density(iris1)
iris2_den <- density(iris2)
iris3_den <- density(iris3)

# 밀도 그래프
plot(iris1_den, col = 'red' ,xlim = c(1.5,5), ylim = c(0,1.5))
par(new =T)
plot(iris2_den, col = 'green', ann = F, axes = F,xlim = c(1.5,5), ylim = c(0,1.5))
par(new =T)
plot(iris3_den, col = 'blue', ann = F, axes = F,xlim = c(1.5,5), ylim = c(0,1.5))
legend('topleft', c('Setosa','Versicolor','Virginica'), 
             lwd = 1, lty = 1,  title = 'Species', col = c('red','green','blue'))


# 1) ggplot2 
ggplot(data=iris, aes(x=Sepal.Width, colour = Species)) + 
  geom_density()+
  labs(title = "종별 밀도 그래프") +
  theme(plot.title = element_text(hjust = 0.5))

# 2) plotly - R.ver
library(stringr)

plot_ly(opacity = 1) %>% 
  add_lines(x= ~iris1_den$x, y = ~iris1_den$y, name = 'setosa', color = 'rose') %>%
  add_lines(x= ~iris2_den$x, y = ~iris2_den$y, name = 'versicolor', color = 'green') %>%
  add_lines(x= ~iris3_den$x, y = ~iris3_den$y, name = 'virginica', color = 'blue') %>%
  layout(title = '종별 밀도 그래프',
         xaxis = list(title = 'Sepal.Width'),
         yaxis = list(title = 'density'))
  

  
  
  
  