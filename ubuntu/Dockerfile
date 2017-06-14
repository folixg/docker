# Ubuntu with personalized setup
FROM ubuntu:latest
MAINTAINER Thomas Goldbrunner <thomas.goldbrunner@posteo.de>

# install git
RUN apt-get update && apt-get install -y git sudo

# install my config
RUN git clone https://github.com/folixg/dot-files.git /root/dot-files \
  && cd /root/dot-files \
  && git submodule init \
  && git submodule update \
  && ./setup.sh --headless

# cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
