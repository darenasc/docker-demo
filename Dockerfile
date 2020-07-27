FROM python:3.7

RUN apt-get update && apt-get install -y vim && pip install psycopg2 beautifulsoup4 lxml
