FROM jenkins/jenkins:2.263.3-lts-jdk11
USER root
RUN apt-get update && apt-get install -y apt-transport-https \
	ca-certificates curl gnupg2 \
	software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - 
RUN apt-key fingerprint 0EBFCD88
RUN add-apt-repository \
	"deb [arch=amd64] https://download.docker.com/linux/debian \
	$(lsb_release -cs) stable"
RUN apt-get update && apt-get install -y docker-ce-cli
RUN apt-get update \
      && apt-get install -y sudo \
      && rm -rf /var/lib/apt/lists/*

#Adding jenkins to sudoers list and making an alias for sudo docker
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers \
      && printf '#!/bin/bash\nsudo /usr/bin/docker "$@"' > /usr/local/bin/docker \
      && chmod +x /usr/local/bin/docker
RUN usermod -a -G root jenkins
RUN chmod a+rw /var/run/docker.sock
USER jenkins
RUN jenkins-plugin-cli --plugins blueocean:1.24.4