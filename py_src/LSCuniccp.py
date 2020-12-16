import matplotlib.pyplot as plt
import pandas as pd

def sendfunc(rows2):

    #Extract schemas from the list
    ext_schemas = [i[0] for i in rows2]

    #Extract values from the list
    ext_values = [i[1] for i in rows2]

    #Convert the values into int
    int_values = [int(j) for j in ext_values]

    def merge(list1, list2): 
        
        merged_list = [(list1[i], list2[i]) for i in range(0, len(list1))] 
        return merged_list

    list1 = ext_schemas
    list2 = int_values
    new_rows2 = merge(list1, list2) #Feeding new_rows2 into the dataframe to get int values instead of float values

    df = pd.DataFrame(new_rows2)
    df.columns = ['schemas', 'values']

    values = df.loc[:, 'values']
    schemas = df.loc[:, 'schemas']

    pal = ["#43BD78", "#E67188", "#82A1D0", "#DF8E47", "#9C7DA1"]
    ax = df[['values']].T.plot(kind='barh', stacked=True, width=1.3, color=pal, figsize=(20, 10), position=-0.5)
    total = sum(row for row in values)
    total = total // 5
    collection = [0]
    for i in range(1,6):
        collection.append(total*i)
    ii = 0
    for i in ax.patches:
        ax.text(i.get_x()+100 , i.get_height()+0.6, \
                str(values[ii])+" ", fontsize=15,
                color='black', rotation = 90)
        ii += 1

    ax.set(yticks=[])
    ax.set_xticks(collection)

    ax.set_xticklabels(['0%','20%','40%','60%','80%','100%'], fontsize=15)
    ax.legend(ext_schemas, loc='upper center', bbox_to_anchor=(0.475, -0.05), ncol=len(values), prop={'size': 13.5})
    ax.set_frame_on(False)
    plt.ylim(1.5, 5.5)
    plt.savefig('temporary.png', transparent=False, bbox_inches='tight', pad_inches=0.25)

    # Importing Image class from PIL module 
    from PIL import Image 
    
    # Opens a image in RGB mode 
    im = Image.open('temporary.png') 
    
    # Setting the points for cropped image 
    left = 0
    top = 700
    right = 1560
    bottom = 890
    
    # Crop image of above dimension 
    im1 = im.crop((left, top, right, bottom))

    # Resize the cropped image
    newsize = (1000, 100) 
    im2 = im1.resize(newsize)
    
    # Saves the permanent image
    im2.save('graph_images/latestschemacapacity_uniccp.png')