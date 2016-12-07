#!/usr/bin/env bash

if [ -z $1 ]; then
  NOTEBOOK_DIR=~/notebooks
else
  NOTEBOOK_DIR=$1
fi

# kill any running instances
docker stop notebook &>/dev/null && docker rm notebook >/dev/null

docker run -d -p 8888:8888 -v $NOTEBOOK_DIR:/home/jovyan/work --name notebook \
           -e NB_UID=$(id -u) --user root jupyter/base-notebook && \
           echo 'Jupyter notebook server is running at: http://localhost:8888'; \
           echo 'Notebook directory is '$NOTEBOOK_DIR''
