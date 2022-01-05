FROM python:3.9.7
ADD . /flask_backend
WORKDIR /flask_backend
RUN pip install -r requirements.txt
CMD ["src/main.py"]
ENTRYPOINT ["python"]