FROM python:3.7

COPY ./requirements.txt ./app/requirements.txt

WORKDIR /app

RUN pip install -r requirements.txt

COPY . /app

EXPOSE 80

CMD uvicorn main:app --host 0.0.0.0 --port 80 --reload