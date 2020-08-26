FROM nacyot/ubuntu

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get -y install gcc

RUN add-apt-repository ppa:ubuntu-toolchain-r/test
RUN apt update
RUN apt-get install -y gfortran-7

RUN mkdir -p gfortran-symlinks
RUN ln -s /usr/bin/gfortran-7 gfortran-symlinks/gfortran
RUN export PATH=$PWD/gfortran-symlinks:$PATH

FROM python:3.6.8

COPY requirements.txt /opt/app/requirements.txt
COPY setup.sh /opt/app/setup.sh

WORKDIR /opt/app
RUN pip install -r requirements.txt
COPY . /opt/app

RUN setup.sh

