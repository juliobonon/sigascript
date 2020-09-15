from bot import Bot
from flask import Flask, request, jsonify
from os import sys

app = Flask(__name__)

@app.route('/', methods=['GET'])
def home():
    return '''<h1>Siga</h1>
<p>Uma API para retornar dados do SIGA</p>'''

@app.route('/grades', methods=['GET'])
def api_gatry():
    return jsonify(list), 200

@app.route('/login', methods=['POST'])
def login():
    login = request.form.get('rg')
    password = request.form.get('password')
    bot = Bot()

    msg = ''
    if (bot.site_login(login, password) == 0):
        msg = 'Success'
        return jsonify(msg), 200
    else:
        msg = 'Failure'
        return jsonify(msg), 404

    
       
    
if __name__ == "__main__":
    ip = sys.argv[1]
    app.run(host=ip)

