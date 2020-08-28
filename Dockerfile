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
		    wget \
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


#RUN apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libsqlite3-dev libreadline-dev libffi-dev wget libbz2-dev
#RUN wget https://www.python.org/ftp/python/3.7.4/Python-3.7.4.tgz

#RUN tar -xf Python-3.7.4.tgz
#RUN cd Python-3.7.4
#RUN ./configure --enable-optimizations
#RUN make -j 8
#RUN 


RUN pip install --upgrade pip
RUN pip install -U setuptools
RUN pip install -U wheel

ADD requirements.txt .
RUN pip3 install -r requirements.txt

COPY requirements.txt /opt/app/requirements.txt
COPY setup.sh /opt/app/setup.sh

WORKDIR /opt/app
RUN pip3 install -r requirements.txt
COPY . /opt/app

RUN setup.sh

