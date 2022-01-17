from flask import Flask, jsonify
from flask_basicauth import BasicAuth
import logging
import tensorflow as tf
from tensorflow import keras

# Setup logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger()

app = Flask(__name__)
app.config['BASIC_AUTH_USERNAME'] = 'clc3'
app.config['BASIC_AUTH_PASSWORD'] = 'clc3'
basic_auth = BasicAuth(app)


@app.route('/')
def index():
    logger.info("request received; path: '/'")
    return "passport flask_backend is running!"


@app.route('/predict', methods=['POST'])
@basic_auth.required
def predict():
    logger.info("request received; path: '/predict'")
    response = {"msg": "ok"}
    new_model = tf.keras.models.load_model('model.hdf5')

    # Check its architecture
    print(new_model.summary())
    return jsonify(response), 200


if __name__ == '__main__':
    app.run(host="0.0.0.0", debug=True, port=8080)
    logger.info('flask app started successfully')
