FROM python:3.7.9

WORKDIR /app
COPY app.py ./
ENTRYPOINT ["python3", "-u", "app.py"]
