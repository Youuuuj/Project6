#설정
#한글 깨짐 방지
import matplotlib
import matplotlib.font_manager as fm
font_name = fm.FontProperties(fname = 'C:/Windows/Fonts/malgun.ttf').get_name()
matplotlib.rc('font', family = font_name)
matplotlib.rcParams['axes.unicode_minus'] = False
#사용기능 불러오기
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

#kaggle의 타이타닉 데이터 활용
df = pd.read_csv("https://raw.githubusercontent.com/yganalyst/data_example/main/titanic/train.csv", dtype=str)
df[["Age","Fare","Pclass"]] = df[["Age","Fare","Pclass"]].astype(float)
df["Age"] = df["Age"].fillna(df["Age"].median())
df.head(5)

#막대그래프
bar_df = df["Survived"].value_counts().reset_index() #Survived열 데이터 전처리 *생존자
plt.figure(figsize = (7,5)) #그래프 크기 지정
plt.title("Bar Plot", fontsize = 10) #그래프 제목 지정
plt.bar(bar_df["index"], bar_df["Survived"],color=('r','b'), alpha = 0.8) #x,y축 지정, 색 지정, 투명도 지정
plt.ylabel("사람 수", fontsize = 10) #y축 제목 지정, 글자 크기 지정
plt.xlabel("생존여부", fontsize = 10) #x축 제목 지정, 글자 크기 지정
plt.show()

#박스그래프
df.boxplot('Age', 'Survived') #Age와 Survived간의 박스 그래프
plt.xlabel('Age', fontsize = 10) #x축 제목 및 글자 크기 지정
plt.ylabel('Survived', fontsize = 10) #y축 제목 및 글자 크기 지정
plt.show()

#산점도
plt.figure(figsize = (7,5))# 그래프 크기 지정
plt.title("Scatter Plot", fontsize = 10)# 그래프 제목 지정
plt.scatter(df["Age"], df["Fare"], color = "skyblue", alpha = 0.5)
# Age, Fare 간의 산점도, 산점도 색상,투명도 지정
plt.xlabel("Age", fontsize = 10) #x축 제목 및 글자 크기 지정
plt.ylabel("Fare", fontsize = 10) #y축 제목 및 글자 크기 지정
plt.grid() # 격자 표시
plt.show()

#3D산점도
from mpl_toolkits.mplot3d import Axes3D
#3D산점도를 구현하기 위해 사용
df_t = df[df["Fare"]<=200] #Fare 200이하로 설정하여 데이터 전처리
fig = plt.figure(figsize = (8, 6)) #그래프 크기지정
plt.title("K_Clusters") #그래프 제목 지정
ax = Axes3D(fig) #3D격자 생성
for i in ["male", "female"]: #성별 기준으로 색상 구분 및 범례생성
    tt = df_t[df_t["Sex"]==i]
    ax.scatter(tt["Age"], tt["Fare"], tt["Pclass"], alpha=0.5, label=i,)
ax.set_xlabel('Age', fontsize=10) #x축 제목 및 글자 크기 지정
ax.set_ylabel('Fare', fontsize=10) #y축 제목 및 글자 크기 지정
ax.set_zlabel('Pclass', fontsize=10) #z축 제목 및 글자 크기 지정
ax.legend(fontsize=10) #범례 글자 크기 지정
plt.show()


