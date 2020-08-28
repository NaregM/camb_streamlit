#FROM python:3.6-alpine3.7

#RUN apk add --no-cache --update \
#    python3 python3-dev gcc\
#    gfortran musl-dev g++ \
#    libffi-dev openssl-dev \
#    libxml2 libxml2-dev \
#    libxslt libxslt-dev \
#    libjpeg-turbo-dev zlib-dev

#RUN pip install --upgrade pip

#ADD requirements.txt .
#RUN pip install -r requirements.txt

#COPY requirements.txt /opt/app/requirements.txt
#COPY setup.sh /opt/app/setup.sh

#WORKDIR /opt/app
#RUN pip install -r requirements.txt
#COPY . /opt/app

#RUN setup.sh

FROM centos:latest

RUN yum update -y
# add gfortran, debugging tools and make
RUN yum install -y gcc-gfortran gdb make 


RUN pip install --upgrade pip

ADD requirements.txt .
RUN pip install -r requirements.txt

COPY requirements.txt /opt/app/requirements.txt
COPY setup.sh /opt/app/setup.sh

WORKDIR /opt/app
RUN pip install -r requirements.txt
COPY . /opt/app

RUN setup.sh





















