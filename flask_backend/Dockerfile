FROM tensorflow/tensorflow:devel
ADD . /flask_backend
WORKDIR /flask_backend
RUN pip install -r requirements.txt
ENTRYPOINT ["python", "src/main.py"]