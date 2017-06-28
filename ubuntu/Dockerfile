# Ubuntu with personalized setup
FROM ubuntu:latest
MAINTAINER Thomas Goldbrunner <thomas.goldbrunner@posteo.de>

# install ansible
RUN apt-get update \
&& apt-get install -y software-properties-common \
&& apt-add-repository -y ppa:ansible/ansible \
&& apt-get update \
&& apt-get install -y ansible


# cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
