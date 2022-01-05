from flask import Flask, jsonify
from flask_basicauth import BasicAuth

app = Flask(__name__)
app.config['BASIC_AUTH_USERNAME'] = 'clc3'
app.config['BASIC_AUTH_PASSWORD'] = 'clc3'
basic_auth = BasicAuth(app)


@app.route('/')
def index():
    return "passport flask_backend is running!"


@app.route('/predict', methods=['POST'])
@basic_auth.required
def predict():
    response = {"msg": "ok"}
    return jsonify(response), 200


if __name__ == '__main__':
    app.run(host="0.0.0.0", debug=True, port=8080)