# Amazon Glacier CLI installed on Ubuntu
FROM ubuntu:latest
MAINTAINER Thomas Goldbrunner <thomas.goldbrunner@posteo.de>

# install git and pip
RUN apt-get update && apt-get install -y python-pip git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/uskudnik/amazon-glacier-cmd-interface.git

WORKDIR amazon-glacier-cmd-interface

RUN python setup.py install
