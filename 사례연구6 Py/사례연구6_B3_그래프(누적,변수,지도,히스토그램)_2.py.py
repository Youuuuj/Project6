#누적막대

import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns
v = pd.read_csv('C:/Rwork/dataset3/dataset3/VADeaths.csv')
print(v)
v=pd.DataFrame(v)
print(v)
v



df_by_group_label = v
df_pivot = df_by_group_label.pivot(index='location',columns='age',values='deaths')
df_pivot


df_pivot.plot.bar(stacked=True, rot=0)
plt.savefig('누적막대그래프.png')
#히스토그램
import matplotlib.pyplot as plt
import pandas as pd
i = pd.read_csv('C:/Rwork/dataset3/dataset3/iris.csv')
print(i)


i.plot.hist(y='Sepal.Length')

plt.show()
plt.savefig('히스토그램.png')

#변수간 비교
i = pd.read_csv('C:/Rwork/dataset3/dataset3/iris.csv')
sns.pairplot(i, diag_kind='hist')

plt.show()

plt.savefig('변수간비교.png')

#지도 시각화

# 해당 기능 없음

