FROM gliderlabs/alpine:3.1

MAINTAINER Fábio Uechi <fabio.uechi@gmail.com>

RUN apk add --update \
    python \
    python-dev \
    py-pip \
    build-base \
    wget \
    ffmpeg \
  && pip install virtualenv python-application==1.5.0 cython\
  && rm -rf /var/cache/apk/*

RUN wget http://download.ag-projects.com/SipClient/python-sipsimple-2.5.0.tar.gz -P /tmp/
RUN tar -zxvf /tmp/python-sipsimple-2.5.0.tar.gz -C /tmp
RUN apk add libavformat
RUN cd /tmp/python-sipsimple-2.5.0 && python setup.py install
# RUN apt-get update && apt-get install -y python-pip python-sipsimple sipclients libasound2 alsa-utils alsa-oss
# CMD ["/bin/bash"]
