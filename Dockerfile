FROM ubuntu:20.04

RUN apt-get update && apt-get install -y python3-pip && apt-get clean

WORKDIR /djangoproject

COPY ./requirements.txt .
RUN pip3 install -r requirements.txt

COPY manage.py .
COPY mysite ./mysite

RUN which gunicorn || echo gunicorn not found

EXPOSE 8000
CMD ["gunicorn", "mysite.wsgi:application", "--bind", "0.0.0.0:80"]
