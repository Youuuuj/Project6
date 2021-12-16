#막대차트,상자그래프,산점도,3차원산점도

#설치
#install.packages('ggplot2')
#install.packages('plotly')
#install.packages("scatterplot3d")

#실행
library(ggplot2)
library(plotly)
library(scatterplot3d)

#사용 데이터
#data(diamonds)
#data(mpg)
#data(iris)



#1 {ggplot2}

#================================================================#
#1-1 막대차트 ; {ggplot2} qplot()함수 사용

#gplot() 형식 : qplot(x축 ~ y축, data, facet, geom., stat, position, xlim,  
#                     ylim, log, main, xlab, ylab, asp, *binwidth)

#데이터 사용 : {ggplot2} 'mpg'

str(mpg)
qplot(hwy, data = mpg, binwidth = 1, # hwy : 고속도로 연비
                                     # 'binwitdth  =' : 막대그래프 넓이
      xlab = '고속도로 연비', # x축 이름 설정
      main = 'mpg 데이터셋 내 hwy에 대한 그래프', # 그래프 이름 지정
      fill = drv, # drv : 2륜, 4륜, 후륜구동 
                  # hwy 막대그래프를 drv 변수로 색상 구분
      facets = .~ drv) # hwy 그래프를 열기준으로 drv변수로 세분화하여 분리

#================================================================#
#1-2 상자그래프 ;  {ggplot2} ggplot()+geom_boxplot() 사용

#ggplot()+geom_boxplot() 형식 : ggplot(data, aes(x = , y = ,)) + 
#                               geom_boxplot(aes, ...)

#데이터 사용 : {ggplot2} 'mpg'

ggplot(mpg, aes(x = drv, y = hwy)) +
  geom_boxplot(color = 'black', # box에 색 지정
               outlier.color = 'red', # 이상치의 테두리 색 지정
               outlier.fill = 'yellow', # 이상치의 내부 색 지정
               outlier.size = 3, # 이상치의 크기 지정
               outlier.stroke = 1, # 이상치의 테두리 두께 지정
               outlier.shape = 22, # 이상치의 모양 지정
               outlier.alpha = 1, # 이상치의 투명도 지정
               notch = T) #+ coord_flip() # coord_flip() x,y축 변경
               #notch = F ; default, T일경우 boxplot의 모양이 바뀜

#================================================================#
#1-3 산점도 ; {ggplot2} ggplot()+geom_boxplot() 사용

#ggplot()+geom_boxplot()) 형식 : ggplot(data, aes(x = , y = ,)) + 
#                                geom_point(aes, ...)

#데이터 사용 : {ggplot2} 'mpg'

ggplot(mpg, aes(x = displ, y = hwy)) + # displ : 엔진 배기량(리터당)
  geom_point(size = 1, # 산점도 크기 지정
             shape = 21, # 산점도 모양 지정
             aes(color = drv), # drv 변수로 색 지정 *맵핑 aes사용
             fill = 'black',# 산점도 내부 색 지정
             stroke = 1.5, # 산점도 테두리 두께 지정
             alpha = 0.5)# + # 산점도 투명도 지정
  #geom_smooth(method = 'lm') # * 회귀선 추가가능

#================================================================#
#1-4 3D산점도 ; {scatterplot3d} scatterplot3d() 사용 
#{ggplot} 3D를 지원하는 기능이 제한되어 {scatterplot3d}사용

#scatterplot3d() 형식 : scatterplot3d(data$a, data$b, data$c, 
#                             type = 'n'|'p'|'l', ...)

#데이터 사용 : {ggplot2} 'mpg'

#3D 산점도, drv변수 기준 색 지정을 위한 작업
table(mpg$drv)
colors <- c("violet", "skyblue", "gold")
colors <- colors[as.numeric(factor(mpg$drv))]

#scatterplot3d 시각화
d3 <- scatterplot3d(mpg$hwy, factor(mpg$fl), mpg$displ, 
                    # fl : 연료 ; 도식을 위해 변환
                    main = '3D 산점도', # 산점도 제목 지정
                    xlab = '고속도로 연비', # x축 이름 지정
                    ylab = '연료 종류', # y축 이름 지정
                    zlab = '배기량', # z축 이름 지정
                    type = 'p', # 그래프 표시방법 ; p:점, l:선, ...
                    angle = 50, # 그래프 앵글 지정
                    pch = 16, # 산점도 모양 지정
                    color = colors) #산점도 색 지정

#범례 추가
legend(d3$xyz.convert(40, 5, 4.5), # 범례 위치 설정, 변수의 xyz값 사용
       legend = levels(factor(mpg$drv)), # 범례 내용 
       col = c("violet", "skyblue", "gold"), # 범례 내용 색 지정
       pch = 16, # 범례 모양 지정
       cex = 0.8, # 범례 크기 지정
       title = 'drv') # 범례 제목 지정

#----------------------------------------------------------------#
#2 {plotly}

#================================================================#
#2-1 막대차트 ; {plotly} plot_ly() 사용
#mpg데이터셋 drv변수에 대한 빈도수를 도식

# plot_ly() 형식 : plot_ly(data, x, y, type = 'bar'
#                          marker = list(color = '',
#                                line = list(color = '', width = '')))

#데이터 사용 : {ggplot2} 'mpg'

drv <- table(mpg$drv)
drv <- data.frame(drv)
colnames(drv) <- c('drv', 'Freq')
drv

plot_ly(drv, x = ~drv, y = ~Freq, type = 'bar',
        marker = list(color = 'rgb(100,100,100)',
        # marker 옵션을 사용하여 막대차트 내 색 지정              
                      line = list(color = 'rgb(20,900,50)', width = 2.5))) %>%
          # marker 옵션을 사용하여 막대차트 테투리 색,두께 지정
  layout(title = 'drv 빈도수에 대한 막대 그래프')
  # %>% 와 layout()을 사용한 제목 지정

#================================================================#
#2-2 상자그래프

# plot_ly() 형식 : plot_ly(data, x, y, type = 'box',
#                          color = '', boxpoints = '', marker = ...)

#데이터 사용 : {ggplot2} 'mpg'

plot_ly(mpg, x = ~drv, y = ~hwy, type = 'box', 
        color = ~drv, # 색 지정
        boxpoints= 'outliers', # 이상치 표시
        marker = list(color = 'pink'), # 이상치 색 지정
        line = list(color = 'black')) %>% # 상자그래프 테두리 색 지정
  layout(title = 'drv와 hwy간의 박스 그래프') 
  # %>% 와 layout()을 사용한 제목 지정


#================================================================#
#2-3 산점도

# plot_ly() 형식 : plot_ly(data, x, y,
#                          color = '', alpha = '', ...)

#데이터 사용 : {ggplot2} 'mpg'

plot_ly(mpg, x = ~displ, y = ~hwy, 
        color = ~drv, # drv변수로 산점도 색 지정
        alpha = 1, # 산점도 투명도 지정
        marker = list(size = 5, # 산점도 크기 지정
                      line = list(color = 'black', # 산점도 테투리 색 지정
                                  width = 0.5))) %>%  # 산점도 테투리 두께 지정
  layout(title = 'hwy와 displ간의 산점도')  
  # %>% 와 layout()을 사용한 제목 지정

#================================================================#
#2-4 3D산점도 ; {plotly} plot_ly() 사용 

#plot_ly() 형식 : plot_ly(data, x, y, z, *default type = scatter
#                        color = '', alpha = '', ...)

#데이터 사용 : {ggplot2} 'mpg'
mpg$fl <- as.factor(mpg$fl)
mpg$drv <- as.factor(mpg$drv)
data(mpg)

plot_ly(mpg, x = mpg$displ, y = mpg$fl, z= mpg$hwy,
        alpha = 0.75, # 산점도 투명도 지정
        color = mpg$drv, # drv 변수 기준 색상 지정
        colors = c("violet", "skyblue", "gold"))%>%
        # drv 변수를 기준으로 지정 색상 부여
  add_markers() %>% # add_markers()를 이용하여 각 축에 제목 설정
  layout(scene = list(xaxis = list(title = 'displ'), #x축 
                      yaxis = list(title = 'fl'),  #y축 
                      zaxis = list(title = 'hwy'))) #z축 

#----------------------------------------------------------------#






























