### Personalized Ubuntu setup
Dockerfile for automated builds on [Dockerhub](https://hub.docker.com/r/folixg/ubuntu)

Pull command: ```docker pull folixg/ubuntu```

Following steps are taken:
1. Install git and ansible
2. Clone my [dot-files](https://github.com/folixg/dot-files) repository
3. Run the ansible playbook [docker.yml](https://github.com/folixg/dot-files/blob/master/playbooks/docker.yml) 
on localhost.

