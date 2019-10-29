FROM debian:stretch
MAINTAINER David Kainz "dkainz@mgit.at"

#RUN cp /etc/apt/sources.list /etc/apt/sources.list.d/deb-src.list
RUN sed 's/deb /deb-src /g' /etc/apt/sources.list > /etc/apt/sources.list.d/deb-src.list

RUN apt-get -y update && apt-get -y install \
    build-essential wget unzip uuid-dev

RUN apt-get -y build-dep nginx
RUN adduser --uid 1000 --home /srv/build builder

COPY ./build-pagespeed.sh /srv/build-pagespeed.sh
COPY ./files /srv/files

ENTRYPOINT /srv/build-pagespeed.sh
VOLUME /srv/build
USER builder
