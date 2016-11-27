import csv

#4.2426---3.6056
dic_1 = {'4.2426': 18,
         '3.1623': 8,
         '3.6056': 13}
#5 (4)
dic_2 = {'2.2361': 7,
         '2.8284': 12,
         '3.6056': 17,
         '4.2426': 18,
         '5': 19}
#5 (7)
dic_3 = {'4.4721': 14,
         '4.1231': 9,
         '3.1623': 8,
         '2.2361': 7,
         '2.8284': 12,
         '3.6056': 17,
         '4.2426': 18,
         '5':19}

dic = {'1': 1,
       '2': 2,
       '3': 3,
       '4': 4,
       '5': 5,
       '1.4142': 6,
       '5.0990': 10,
       '5.3852': 15,
       '5.8310': 20,
       '6.4031': 25,
       '5.6569': 24,
       '4.4721': 22,
       '4.1231': 21,
       '2.2361': 7,
       '3.1623': 16,
       '2.8284': 12}

lst_1 = ['4.4721', '4.1231','3.1623', '2.2361', '2.8284', '3.6056', '4.2426', '5']
lst_2 = ['2.2361', '2.8284', '3.6056', '4.2426', '5']
lst_3 = ['4.2426', '3.1623', '3.6056']

def contains(small, big):
    for i in xrange(len(big)-len(small)+1):
        for j in xrange(len(small)):
            if big[i+j] != small[j]:
                break
        else:
            return True
    return False

def classify(row):

    if (contains(lst_1, row)):
        return 3
    if (contains(lst_2, row)):
        return 2
    if (contains(lst_3, row)):
        return 1
    return -1

with open ('observations.csv', 'r') as ipt:
    with open ('result.csv', 'wb') as opt:
        reader = csv.reader(ipt)
        writer = csv.writer(opt, lineterminator='\n')
        writer.writerow(['Id', 'Category'])
        d = 1
        x = 1
        for row in reader:
            i = classify(row)
            last_ele = row[99]
            to_be_w = -100
            if (i == 1):
                if (last_ele in lst_3):
                    to_be_w = dic_1[last_ele]
                else :
                    to_be_w = dic[last_ele]
            elif (i == 2):
                if (last_ele in lst_2):
                    to_be_w = dic_2[last_ele]
                else :
                    to_be_w = dic[last_ele]
            elif (i == 3):
                if (last_ele in lst_1):
                    to_be_w = dic_3[last_ele]
                else :
                    to_be_w = dic[last_ele]
            if (d > 200):
                writer.writerow([x, to_be_w])
                x += 1
            d += 1                      
