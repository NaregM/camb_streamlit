FROM        ubuntu

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
		#&& apt instal build-essential \
		#&& apt-get install manpages-dev \
                && apt-get install -y \
                    gcc-7 g++-7\
                    gcc-8 g++-8 \
		    gfortran gfortran-8 \

                && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 100 \
                && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-8 100 \
		&& update-alternatives --install /usr/bin/gfortran gfortran /usr/bin/gfortran-8 100 

RUN gfortran --version
RUN gcc --version


FROM python

RUN pip3 install --upgrade setuptools

ADD requirements.txt .
RUN pip3 install -r requirements.txt

COPY requirements.txt /opt/app/requirements.txt
COPY setup.sh /opt/app/setup.sh

WORKDIR /opt/app
RUN pip3 install -r requirements.txt
COPY . /opt/app

RUN setup.sh

