FROM debian:stretch
MAINTAINER David Kainz "dkainz@mgit.at"

#RUN cp /etc/apt/sources.list /etc/apt/sources.list.d/deb-src.list
RUN sed 's/deb /deb-src /g' /etc/apt/sources.list > /etc/apt/sources.list.d/deb-src.list

RUN apt-get -y update && apt-get -y install \
    build-essential wget unzip uuid-dev

RUN apt-get -y build-dep nginx
RUN useradd -u 1000 -m builder

USER root

COPY ./build-pagespeed.sh /home/builder/build-pagespeed.sh
COPY ./patches /home/builder/patches
