from flask import Flask, request, jsonify
from flask_basicauth import BasicAuth
import logging
import tensorflow as tf
import numpy as np
import cv2
import base64

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

    image_base64 = request.json['Image']

    image_bytes = base64.b64decode(image_base64)
    image_np = np.frombuffer(image_bytes, dtype=np.uint8)
    img = cv2.imdecode(image_np, cv2.IMREAD_UNCHANGED)
    img = cv2.resize(img, (150, 200))
    img = cv2.cvtColor(img, cv2.COLOR_RGB2BGR)
    img_array = tf.keras.preprocessing.image.img_to_array(img)
    img_array = img_array.reshape((1, img_array.shape[1], img_array.shape[0], img_array.shape[2]))

    # with tf.device('/cpu:0'):
    model = tf.keras.models.load_model('model.hdf5')

    prediction = model.predict(img_array)

    best_index = np.argmax(prediction)
    mappings = ["-15", "-30", "-45", "-60", "-75", "-90", "0", "15", "30", "45", "60", "75", "90"]

    response = {"prediction": mappings[best_index]}
    return jsonify(response), 200


if __name__ == '__main__':
    app.run(host="0.0.0.0", debug=True, port=8080)
    logger.info('flask app started successfully')
