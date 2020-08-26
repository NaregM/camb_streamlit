FROM centos:latest
RUN yum update -y
# add gfortran, debugging tools and make
RUN yum install -y gcc-gfortran gdb make 
RUN COMPILER=gfortran

FROM python:3.6.8

FROM cmbant/cosmobox

ENV NB_USER jovyan
ENV NB_UID 1000
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}

WORKDIR ${HOME}
RUN python setup.py build

COPY requirements.txt /opt/app/requirements.txt
COPY setup.sh /opt/app/setup.sh

WORKDIR /opt/app
RUN pip install -r requirements.txt
COPY . /opt/app

RUN setup.sh

