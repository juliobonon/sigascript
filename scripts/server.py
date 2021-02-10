from bot import Bot
from flask import Flask, request, jsonify
import os

app = Flask(__name__)

@app.route('/', methods=['GET'])
def home():
    return '''<h1>Siga</h1>
<p>Uma API para retornar dados do SIGA</p>'''

@app.route('/grades', methods=['GET'])
def api_gatry():
    bot = Bot()
    list = []
    bot.parse_grades2()
    return jsonify(list), 200

@app.route('/profile', methods=['GET'])
def profile():
    bot = Bot()
    list = bot.get_profile_data()
    return jsonify(list), 200

@app.route('/login', methods=['POST'])
def login():
    bot = Bot()
    login = request.form.get('rg')
    password = request.form.get('password')

    msg = ''
    if (bot.site_login(login, password) == 0):
        msg = 'Success'
        return jsonify(msg), 200
    else:
        msg = 'Failure'
        return jsonify(msg), 404

@app.route('/presences', methods=['GET'])
def presences():
    bot = Bot()
    list = []
    list = bot.merge_grades()
    return jsonify(list), 200

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 3000))
    app.run(host='0.0.0.0', port=port, threaded=True)

