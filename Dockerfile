FROM debian:bullseye
MAINTAINER datapunt@amsterdam.nl

RUN ln -sf /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime

ARG DEBIAN_FRONTEND=noninteractive

ARG SWIFT_AUTH_URL
ENV SWIFT_AUTH_URL=${SWIFT_AUTH_URL}

ARG SWIFT_REGION
ENV SWIFT_REGION=${SWIFT_REGION}

ARG SWIFT_PROJECT_ID
ENV SWIFT_PROJECT_ID=${SWIFT_PROJECT_ID}

ARG SWIFT_DOMAIN_ID
ENV SWIFT_DOMAIN_ID=${SWIFT_DOMAIN_ID}

ARG SWIFT_USER_NAME
ENV SWIFT_USER_NAME=${SWIFT_USER_NAME}

ARG SWIFT_USER_PASSWORD
ENV SWIFT_USER_PASSWORD=${SWIFT_USER_PASSWORD}

ARG DST_SWIFT_PROJECT_ID
ENV DST_SWIFT_PROJECT_ID=${DST_SWIFT_PROJECT_ID}

ARG DST_SWIFT_USER_NAME
ENV DST_SWIFT_USER_NAME=${DST_SWIFT_USER_NAME}

ARG DST_SWIFT_USER_PASSWORD
ENV DST_SWIFT_USER_PASSWORD=${DST_SWIFT_USER_PASSWORD}

ARG MERCATO_CONTAINER
ENV MERCATO_CONTAINER=${MERCATO_CONTAINER}

ARG MAKKELIJKEMARKT_CONTAINER
ENV MAKKELIJKEMARKT_CONTAINER=${MAKKELIJKEMARKT_CONTAINER}

ARG BRIEVENBUS_SERVER
ENV BRIEVENBUS_SERVER=${BRIEVENBUS_SERVER}

ARG BRIEVENBUS_USERNAME
ENV BRIEVENBUS_USERNAME=${BRIEVENBUS_USERNAME}

ARG BRIEVENBUS_PASSWORD
ENV BRIEVENBUS_PASSWORD=${BRIEVENBUS_PASSWORD}

ARG BRIEVENBUS_PORT
ENV BRIEVENBUS_PORT=${BRIEVENBUS_PORT}

ARG GPG_PUBLIC_BASE64
ENV GPG_PUBLIC_BASE64=${GPG_PUBLIC_BASE64}

ARG GPG_PRIVATE_BASE64
ENV GPG_PRIVATE_BASE64=${GPG_PRIVATE_BASE64}

RUN apt-get update \
 && apt-get -y dist-upgrade \
 && apt-get -y clean \
 && apt-get -y autoremove

RUN apt-get -y install sshpass curl unzip gpg python3-swiftclient

COPY app /app

WORKDIR /app

