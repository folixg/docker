#!/usr/bin/env bash

function printhelp {
  echo "Possible options:
  -h : print this help
  -d : set the base directory for the server (needs to be an absolute path) [default: \$PWD]
  -s : select which server to run: minimal or scipy [default: minimal]
  -n : set the name for the docker container [default: jupyter-notebook]
  -p : select which port to use [default: 8888]
  -f : force, i.e. remove all docker containers with conflicting names or ports"
  exit 0
}

# set default values
directory="$PWD"
notebook="minimal"
port="8888"
name="jupyter-notebook"
force="0"

# get commandline arguments
while getopts ":hs:n:d:p:f" opt; do
  case $opt in
    h)
      printhelp
    ;;
    d)
      directory="$OPTARG"
      if ! [ -d "$directory" ] ; then
        echo "'$directory' is not a directory."
        exit 1
      fi
    ;;
    s)
      notebook="$OPTARG"
      if ! [[ $notebook == "minimal" || $notebook == "scipy" ]] ; then
        echo "illegal choice for notebook: '$notebook'. valid options are 'minimal' or 'scipy'"
        exit 1
      fi
    ;;
    n)
      name="$OPTARG"
    ;;
    f)
      force="1"
    ;;
    p)
      case $OPTARG in
        ''|*[!0-9]*)
          echo "illegal value for port number"
          exit 1
        ;;
        *)
          port="$OPTARG"
        ;;
      esac
    ;;
    *)
      echo "unknown option. Use -h to get usage information."
      exit 1
    ;;
  esac
done

# check, whether we can use the port
port_in_use=$(docker ps -a --format '{{.Names}}\t{{.Ports}}' | grep "$port"/tcp)
if [ "$port_in_use" ] ; then
  if [ $force == "1" ] ; then
    IFS=$'\t' read -r -a container <<< "$port_in_use"
    docker rm -f "${container[0]}" &>/dev/null
  else
    echo "port '$port' is already in use by another docker container"
    echo "either select another port, or remove the following container"
    docker ps -a --format '{{.ID}}\t{{.Names}}\t{{.Ports}}\t{{.Status}}' | grep "$port"/tcp
    exit 1
  fi
fi
# check, whether we can use the name
name_in_use=$(docker ps -a --format '{{.Names}}' | grep "$name")
if [ "$name_in_use" ] ; then
  if [ $force == "1" ] ; then
    # remove all containers with specified name
    docker rm -f "$name" &>/dev/null
  else
    echo "name '$name' is already in use by another docker container"
    echo "either select another name, or remove the following container"
    docker ps -a --format '{{.ID}}\t{{.Names}}\t{{.Status}}' | grep "$name"
    exit 1
  fi
fi
# start the docker container
docker run -d -p "$port":8888 -v "$directory":/home/jovyan/work \
--name "$name" -e NB_UID="$(id -u)" --user root \
jupyter/"$notebook"-notebook start-notebook.sh \ --NotebookApp.token='' \
1>/dev/null && \
echo "Jupyter notebook server is running at: http://localhost:$port" && \
echo "Notebook directory is '$directory'" && \
if [ "$notebook" == "scipy" ] ; then
  echo "(scipy-notebook might take some time, before the server is actually reachable)"
fi
