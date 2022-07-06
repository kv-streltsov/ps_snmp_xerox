import os
import json
import subprocess
data=[]

#open pars file
with open(os.path.join('path','fileName'), 'r',encoding='UTF-16') as outfile:
    for line in outfile:
        if len(line) > 5:
            data.append(line.strip().split(':'))

#pars
i = (len(data)/5)
x = 0
count1 = 0
count2 = 5
pars_data = []


while x < i:
    x = x + 1
    a =  data[count1:count2]
    count1 = count1 + 5
    count2 = count2 + 5
     
    dic_data = {'ip'              :a[0][1].strip(),
                'toner_level'     :a[4][1].strip(),
                'printer_model'   :a[1][1].strip(),
                'serial_number'   :a[3][1].strip(),
                'printer_location':a[2][1].strip()}

    pars_data.append(dic_data)


#export json
with open(os.path.join('path','fileName'), 'w') as outfile:
     json.dump(pars_data, outfile)
data.clear()

#open pars file
with open(os.path.join('path','fileName'), 'r',encoding='UTF-16') as outfile:
    for line in outfile:
        if len(line) > 5:
            data.append(line.strip().split(':'))

#pars
i = (len(data)/15)
x = 0
count1 = 0
count2 = 15
pars_data = []

while x < i:
    x = x + 1
    a =  data[count1:count2]
    count1 = count1 + 15
    count2 = count2 + 15
         
    dic_data = {'ip'                              :a[0][1].strip(),
                'printer_model'                   :a[1][1].strip(),
                'printer_location'                :a[2][1].strip(),
                'serial_number'                   :a[3][1].strip(),
                'toner_level_black'               :a[4][1].strip(),
                'toner_level_cyan'                :a[5][1].strip(),
                'toner_level_magenta'             :a[6][1].strip(),
                'toner_level_yellow'              :a[7][1].strip(),
                'Current_drum_toner_level_black'  :a[8][1].strip(),
                'Current_drum_toner_level_cyan'   :a[9][1].strip(),
                'Current_drum_toner_level_magenta':a[10][1].strip(),
                'Current_drum_toner_level_yellow' :a[11][1].strip(),
                'toner_waste_container'           :a[12][1].strip(),
                'transfer_belt_cleaner'           :a[13][1].strip(),
                'second_bias_transfer_roller'     :a[14][1].strip()}

    pars_data.append(dic_data)

#export json
with open(os.path.join('path','fileName'), 'w') as outfile:
     json.dump(pars_data, outfile)
