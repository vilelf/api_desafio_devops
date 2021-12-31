FROM python:3.8.5-alpine as dependencies

WORKDIR /app

COPY requirements.txt requirements.txt

RUN pip install --user -r requirements.txt

COPY . .

FROM python:3.8.5-alpine

WORKDIR /app

COPY --from=dependencies /root/.local /root/.local
COPY --from=dependencies /app/ /app/

ENV PATH=/root/.local/bin:$PATH

EXPOSE 80

ENTRYPOINT ["uvicorn", "main:app", "--reload", "--host", "0.0.0.0", "--port", "80"]