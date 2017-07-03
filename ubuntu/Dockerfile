# Ubuntu with personalized setup
FROM ubuntu:latest
MAINTAINER Thomas Goldbrunner <thomas.goldbrunner@posteo.de>

# install ansible
RUN apt-get update \
&& apt-get install -y software-properties-common \
&& apt-add-repository -y ppa:ansible/ansible \
&& apt-get update \
&& apt-get install -y ansible git

RUN git clone https://github.com/folixg/dot-files.git /root/dot-files \
    && cd /root/dot-files \
    && git submodule init \
    && git submodule update 

RUN cd /root/dot-files/install/playbooks \
    && ansible-playbook -i inventory docker.yml

# cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
