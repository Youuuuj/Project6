# 3. 점 차트
from matplotlib import font_manager, rc  # 한글깨짐 수정
font_name = font_manager.FontProperties(fname="c:/Windows/Fonts/malgun.ttf").get_name()
rc('font', family=font_name)

import matplotlib.pyplot as plt  # 그래프 그리기 위한 함수 불러오기


x2 = [305, 450]
x3 = [320, 460]
x4 = [330, 480]
x5 = [380, 520]

y2 = ['2018년 1분기', '2019년 1분기']
y3 = ['2018년 2분기', '2019년 2분기']
y4 = ['2018년 3분기', '2019년 3분기']
y5 = ['2018년 4분기', '2019년 4분기']

plt.scatter(x2, y2, s=50, c='red')
plt.scatter(x3, y3, s=50, c='blue')
plt.scatter(x4, y4, s=50, c='green')
plt.scatter(x5, y5, s=50, c='violet')
plt.show()



# 4. 원형차트
chart_data = [305, 450, 320, 460, 330, 480, 380, 520]
name =['2018 1분기','2019 1분기','2018 2분기','2019 2분기','2018 3분기','2019 3분기','2018 4분기','2019 4분기']

chart_data
name

plt.pie(chart_data, labels = name, autopct = '%.1f%%', startangle = 90 , counterclock = False)
plt.show()




# 8. 중첩자료 - 버블 차트
import pandas as pd

galton = pd.read_csv('C:/Users/tj-bu/Desktop/galton.csv')
galton[['child', 'parent']]

# 교차 테이블 작성
galton.table = pd.crosstab(galton.child, galton.parent).stack().reset_index(name='C')
galton.table

# 그래프
galton.table.plot.scatter('child', 'parent', s=galton.table.C * 15, alpha=0.5)

plt.scatter(x=galton.table['child'], y=galton.table['parent'],
            s=galton.table['C'] * 15, c=galton.table['C'],
            cmap='rainbow', alpha=0.6, edgecolors='white')
plt.show()


# 10. 밀도 그래프
import matplotlib.pyplot as plt
import seaborn as sns


iris = pd.read_csv('C:/Users/tj-bu/Desktop/iris.csv')


iris[iris['Species'] == 'setosa'].iloc[:,1].plot(kind = 'density', label = 'Setosa', color = 'red')
iris[iris['Species'] == 'versicolor'].iloc[:,1].plot(kind = 'density', label = 'Versicolor', color = 'green')
iris[iris['Species'] == 'virginica'].iloc[:,1].plot(kind = 'density', label = 'Virginica', color = 'blue')
plt.legend(title = 'Species')
plt.title('종별 밀도 그래프')
plt.xlabel('Sepal.Width')
plt.show()




####################### 다른 방법 #########################
iris1 = iris[iris['Species'] == 'setosa']
iris2 = iris[iris['Species'] == 'versicolor']
iris3 = iris[iris['Species'] == 'virginica']

setosa_width = iris1[['Sepal.Width']]
versicolor_width = iris2[['Sepal.Width']]
virginica_width = iris3[['Sepal.Width']]

setosa_df = pd.DataFrame(setosa_width)
versicolor_df = pd.DataFrame(versicolor_width)
virginica_df = pd.DataFrame(virginica_width)


sns.distplot(setosa_df, color = 'red', label = 'setosa', hist = False)
sns.distplot(versicolor_df, color = 'green', label = 'versicolor', hist = False)
sns.distplot(virginica_df, color = 'blue', label = 'virginica', hist = False)
plt.legend(title = 'Species')
plt.title('종별 밀도 그래프')
plt.xlabel('Sepal.Width')
plt.show()