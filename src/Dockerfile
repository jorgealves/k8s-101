FROM python:3-alpine
RUN mkdir /app
WORKDIR /app

ADD requirements.txt /app

RUN pip3 install -r /app/requirements.txt

ADD . /app

ENV FLASK_APP app.py

ENV FLASK_ENV production

EXPOSE 5000

ENTRYPOINT ["flask","run", "--host=0.0.0.0"]