FROM centos:latest
RUN yum update -y
# add gfortran, debugging tools and make
RUN yum install -y gcc-gfortran gdb make 

FROM python:3.6.8

COPY requirements.txt /opt/app/requirements.txt
COPY setup.sh /opt/app/setup.sh

WORKDIR /opt/app
RUN pip install -r requirements.txt
COPY . /opt/app

RUN setup.sh

