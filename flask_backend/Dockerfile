FROM tensorflow/tensorflow:devel
ADD . /flask_backend
WORKDIR /flask_backend
RUN pip install -r ../requirements.txt
WORKDIR /flask_backend/src
ENTRYPOINT ["python", "main.py"]