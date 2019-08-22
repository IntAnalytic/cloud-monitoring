import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
     
fig = plt.figure()
path='capacitydate_uniccp.csv'
df = pd.read_csv(path)
# multiple line plot
plt.figure(figsize=(16,6))

plt.yticks(np.arange(0,110,10))
plt.xticks(np.arange(0,130,13))
plt.tick_params(labelsize=15)
plt.margins(0.01)
plt.axhline(y=20,linewidth=1, color='silver')
plt.axhline(y=40,linewidth=1, color='silver')
plt.axhline(y=60,linewidth=1, color='silver')
plt.axhline(y=80,linewidth=1, color='silver')
plt.axhline(y=100,linewidth=1, color='silver')
plt.axhline(y=10,linewidth=1, color='silver')
plt.axhline(y=30,linewidth=1, color='silver')
plt.axhline(y=50,linewidth=1, color='silver')
plt.axhline(y=70,linewidth=1, color='silver')
plt.axhline(y=90,linewidth=1, color='silver')

plt.ylabel('% Capacity',fontsize = 15)
plt.plot('dateentered','CPU Avg %', data=df, marker='o', markerfacecolor='#B1C1D8', markersize=8, color='#B1C1D8', linewidth=4)
plt.plot('dateentered','Connections % Total', data=df, marker='o', markerfacecolor='#FFACBC', markersize=8, color='#FFACBC', linewidth=4)
plt.plot('dateentered','Storage Capacity %', data=df, marker='o', markerfacecolor='#C7F0A0', markersize=8, color='#C7F0A0', linewidth=4)
plt.plot('dateentered','Table %', data=df, marker='o', markerfacecolor='#C8A8CD', markersize=8, color='#C8A8CD', linewidth=4)
plt.legend(loc='lower center', bbox_to_anchor=(0.5, -0.2),
         shadow=True, ncol=5,frameon=False, fontsize = 15)

plt.savefig("capacity_date_uniccp.png", transparent=False, bbox_inches='tight', pad_inches=0)