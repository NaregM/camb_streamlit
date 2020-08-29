FROM        ubuntu


# Copy our application code
WORKDIR /home/nareg/github/camb_streamlit
COPY . .
COPY requirements.txt .
COPY startup.sh .

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


RUN pip3 install -r requirements.txt

RUN chmod +x startup.sh

RUN startup.sh #["streamlit", "run"]

## Start the app
#CMD streamlit run app.py --bind 0.0.0.0:$PORT # CMD ["streamlit", "run", "app.py"]   # change python to "streamlit", "run"

















