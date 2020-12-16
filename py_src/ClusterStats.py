import numpy as np
import pandas
from pandas import Series, DataFrame
import matplotlib.pyplot as plt
from pylab import rcParams

def sendfunc(rows1):

    import seaborn as sb
    sb.set_style('dark')

    l = list(rows1)

    data = []

    for i in l:
        data.append(list(i))

    length=len(data[0])
    columnNames=[]
    for i in range(0,length):
        columnNames.append(data[0][i])  
    df = pandas.DataFrame(dict(graph=columnNames))

    #for i in range(0,len(data)):
        #print(df.iloc[i]['graph'])

    for i in range(1,len(data)):
        column = [float(c) for c in data[i]]
        if(i==1):
            df['d']=column
        elif i==2:
            df['e']=column
        elif(i==3):
            df['f']=column
        elif(i==4):
            df['g']=column

    ind = np.arange(len(df))
    width = 0.2

    sb.set_style('dark')
    fig, sb = plt.subplots()
    sb.text(df.d, 0, " " + str('CPU (Avg)'), color='black', fontsize=15)
    sb.text(df.e, width, " " + str('Connection (Max)'), color='black', fontsize=15)
    sb.text(df.f, width + width, " " + str('Tables'), color='black', fontsize=15)
    sb.text(df.g, width + width + width, " " + str('Storage Capacity'), color='black', fontsize=15)
    sb.barh(ind, df.d, width, color='#C7F0A0', label='CPU (Avg)')
    sb.barh(ind + width, df.e, width, color='#FFF4B2', label='Connection (Max)')
    sb.barh(ind + width + width, df.f, width, color='#FFACBC', label='Tables')
    sb.barh(ind + width + width + width, df.g, width, color='#B1C1D8', label='Storage Capacity')

    sb.set(yticks=ind, yticklabels=df.graph, ylim=[2*width - 1, len(df)])

    plt.xticks(np.arange(0,110,10))
    plt.grid(axis='x')
    plt.xlabel('Total Capacity %', fontsize=15)
    sb.tick_params(axis= 'x', which='major', labelsize=15)
    plt.rcParams['ytick.labelsize']=12
    #plt.rcParams['axes.labelcolor']='cyan'
    plt.gca().axes.get_yaxis().set_visible(False)

    plt.gcf().set_size_inches(20, 10)
    fig.savefig('graph_images/clusterstats.png',transparent=False, bbox_inches='tight', pad_inches=0)