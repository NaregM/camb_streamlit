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

#FROM centos:latest

#RUN yum update -y
# add gfortran, debugging tools and make
#RUN yum install -y gcc-gfortran gdb make 

#RUN scl enable devtoolset-7 bash

#SHELL [ "/usr/bin/scl", "enable", "devtoolset-7"]


#FROM python

#RUN pip install --upgrade pip

#ADD requirements.txt .
#RUN pip install -r requirements.txt

#COPY requirements.txt /opt/app/requirements.txt
#COPY setup.sh /opt/app/setup.sh

#WORKDIR /opt/app
#RUN pip install -r requirements.txt
#COPY . /opt/app

#RUN setup.sh




FROM centos:7

# Default version of GCC and Python
RUN gcc --version && python --version

# Install some developer style software collections with intent to
# use newer version of GCC and Python than the OS provided
RUN yum install -y centos-release-scl && yum install -y devtoolset-7 rh-python36

# Yum installed packages but the default OS-provided version is still used.
RUN gcc --version && python --version

# Okay, change our shell to specifically use our software collections.
# (default was SHELL [ "/bin/sh", "-c" ])
# https://docs.docker.com/engine/reference/builder/#shell
#
# See also `scl` man page for enabling multiple packages if desired:
# https://linux.die.net/man/1/scl
SHELL [ "/usr/bin/scl", "enable", "devtoolset-7", "rh-python36" ]

# Switching to a different shell has brought the new versions into scope.
RUN gcc --version && python --version
















