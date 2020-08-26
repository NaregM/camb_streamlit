FROM nacyot/ubuntu

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get -y install gcc

RUN apt-get install -y gfortran-8

FROM python:3.7

COPY requirements.txt /opt/app/requirements.txt
COPY setup.sh /opt/app/setup.sh

WORKDIR /opt/app
RUN pip install -r requirements.txt
COPY . /opt/app

RUN setup.sh

