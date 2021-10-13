from bot import Bot
import json
from collections import defaultdict

def read_json():
    file =  open('settings.json', 'r')
    data = json.load(file)
    final_data = data['settings']
    
    return login(final_data['username'], final_data['password'])

def login(rg: str, pw: str):
    bot = Bot()
    bot.site_login(rg, pw)
    print(bot.parse_grades4())

if __name__ == '__main__':
    read_json()
