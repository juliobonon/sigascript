from bot import bot
from flask import Flask, request, jsonify
from os import sys

if __name__ == "__main__":
    ip = sys.argv[1]
    bot = bot()
    bot.site_login()
    bot.find_page()
    list = []
    list = bot.parse_grades()
    print(list)
    app = Flask(__name__)

@app.route('/', methods=['GET'])
def home():
    return '''<h1>Siga</h1>
<p>Uma API para retornar dados do SIGA</p>'''


@app.route('/grades', methods=['GET'])
def api_gatry():
    return jsonify(list), 200


app.run(host=ip)
