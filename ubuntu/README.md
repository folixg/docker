### Personalized Ubuntu setup
Dockerfile for automated builds on [Dockerhub](https://hub.docker.com/r/folixg/ubuntu)

Pull command: ```docker pull folixg/ubuntu```

Following steps are taken:
1. Install git and sudo
2. Clone my [dot-files](https://github.com/folixg/dot-files) repository
3. Perform the software installation and configuration specified
 in [setup.sh](https://github.com/folixg/dot-files/blob/master/setup.sh)

Additional packages installed via apt:
- git
- sudo
- vim
- curl
- zsh
- gnupg2
- python3-pip
- shellcheck

Additional software installed otherwise:
- flake8 (via pip)
- golang 1.8.3 (via [golang.org](https://golang.org/dl/))

Configuration is done for:
- zsh
- bash
- vim
- gpg
- git
