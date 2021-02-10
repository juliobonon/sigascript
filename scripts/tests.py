from bot import Bot
import json
from collections import defaultdict

if __name__ == '__main__':

    bot = Bot()
    file =  open('settings.json', 'r')
    data = json.load(file)
    final_data = data['settings']
    user = final_data['username']
    password = final_data['password']

    bot.site_login(user, password)
    list = bot.parse_grades2()
    #print(json.dumps(list, indent=4, sort_keys=True))
    absent = bot.absent()
    #print(json.dumps(absent, indent=4, sort_keys=True))
    #result = {x['id']:x for x in list + absent}.values()

    result = []
    #list.extend(absent)
    #for myDict in list:
        #if myDict not in result:
            #result.append(myDict)

    dict = defaultdict(dict) #---> working fine 
    for l in (list, absent):
        for elem in l:
            dict[elem['id']].update(elem)
    final_data = dict.values()


   # Iterating and using extend to convert 
    for elm2 in absent: 
    
        for elm1 in list: 
            if elm2['id'] == elm1['id']: 
                elm1.update(elm2) 
                break
        else: 
            list.append(elm2) 
  
 
    print(list) 
    #print(final_data)

