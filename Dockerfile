FROM        ubuntu:xenial

# update and install dependencies
RUN         apt-get update \
                && apt-get install -y \
                    software-properties-common \
                    wget \
                && add-apt-repository -y ppa:ubuntu-toolchain-r/test \
                && apt-get update \
                && apt-get install -y \
                    make \
                    git \
                    curl \
                    vim \
                    vim-gnome \
                && apt-get install -y cmake=3.5.1-1ubuntu3 \
                && apt-get install -y \
                    gcc-4.9 g++-4.9 gcc-4.9-base \
                    gcc-4.8 g++-4.8 gcc-4.8-base \
                    gcc-4.7 g++-4.7 gcc-4.7-base \
                    gcc-4.6 g++-4.6 gcc-4.6-base \
		    gfortran-6 \
                && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 100 \
                && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-6 100



FROM python:3.8

#RUN apt install libpython3.8-dev
RUN pip install --upgrade pip

ADD requirements.txt .
RUN pip install -r requirements.txt

COPY requirements.txt /opt/app/requirements.txt
COPY setup.sh /opt/app/setup.sh

WORKDIR /opt/app
RUN pip install -r requirements.txt
COPY . /opt/app

RUN setup.sh

