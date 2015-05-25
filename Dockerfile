FROM ubuntu:latest
MAINTAINER Fábio Uechi <fabio.uechi@gmail.com>

RUN apt-get install -y wget

RUN wget http://download.ag-projects.com/agp-debian-gpg.key -P /tmp/ && \
    apt-key add /tmp/agp-debian-gpg.key && \
	echo "deb    http://ag-projects.com/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/ag-projects.list    

RUN apt-get update && apt-get install -y python-sipsimple sipclients libasound2 alsa-utils alsa-oss

# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer

USER developer
ENV HOME /home/developer

CMD ["/bin/bash"] 