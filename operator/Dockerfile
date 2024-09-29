FROM python:3.8-slim

WORKDIR /app

COPY ./fastapi_operator.py /app/fastapi_operator.py
COPY ./requirements.txt /app/requirements.txt

RUN pip install -r /app/requirements.txt

CMD ["kopf", "run", "/app/fastapi_operator.py"]
