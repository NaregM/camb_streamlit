FROM        ubuntu


# Copy our application code
WORKDIR /home/nareg/github/camb_streamlit
COPY . .
COPY requirements.txt .

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


RUN apt-get update && apt-get install -y \
        software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get update && apt-get install -y \
        python3.7 \
        python3-pip

RUN python3.7 -m pip install pip
RUN apt-get update && apt-get install -y \
        python3-distutils \
        python3-setuptools


#RUN pip install --upgrade pip
#RUN pip install -U setuptools
#RUN pip install -U wheel

#ADD requirements.txt .
#RUN pip3 install -r requirements.txt

#COPY requirements.txt /opt/app/requirements.txt
#COPY setup.sh /opt/app/setup.sh

#WORKDIR /opt/app
RUN pip3 install -r requirements.txt


# Expose port
#EXPOSE 8501

#ENTRYPOINT ["streamlit", "run"]

# Start the app
CMD streamlit run app.py --server.port 8501 # CMD ["streamlit", "run", "app.py"]   # change python to "streamlit", "run"

















