FROM <CHANGEME>
MAINTAINER David Kainz "dkainz@mgit.at"

RUN sed 's/deb /deb-src /g' /etc/apt/sources.list > /etc/apt/sources.list.d/deb-src.list

RUN set -x \
    && apt-get update -q \
    && apt-get -y -q install build-essential wget unzip uuid-dev \
    && apt-get -y -q build-dep nginx

RUN set -x \
    && adduser --home /srv/build --no-create-home --system --uid 1000 --group builder

COPY ./build-pagespeed.sh /srv/build-pagespeed.sh
COPY ./files /srv/files

ENTRYPOINT [ "/srv/build-pagespeed.sh" ]
VOLUME /srv/build
WORKDIR /srv/build
USER builder
