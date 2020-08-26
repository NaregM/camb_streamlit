FROM ubuntu
# ...
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get -y install gcc mono-mcs && \
    rm -rf /var/lib/apt/lists/*

COPY requirements.txt /tmp/

FROM python:3.7

RUN pip install -r /tmp/requirements.txt

COPY src/ .

