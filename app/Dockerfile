FROM tiangolo/uvicorn-gunicorn-fastapi:python3.8-slim

COPY . /app

RUN pip install -r /app/requirements.txt

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
