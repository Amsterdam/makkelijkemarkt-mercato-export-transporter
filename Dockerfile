FROM debian:stretch
MAINTAINER datapunt@amsterdam.nl

RUN ln -sf /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get -y dist-upgrade \
 && apt-get -y clean \
 && apt-get -y autoremove

RUN apt-get -y install sshpass curl unzip gpg python-swiftclient

COPY app /app

WORKDIR /app

