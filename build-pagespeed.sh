#!/usr/bin/env bash
set -x -e -u
shopt -s extglob
BASEDIR=$(pwd) 
apt-get source nginx

NPS_VERSION=1.13.35.1-beta
wget https://github.com/apache/incubator-pagespeed-ngx/archive/v${NPS_VERSION}.zip
unzip v${NPS_VERSION}.zip
nps_dir=$(find . -name "*pagespeed-ngx-${NPS_VERSION}" -type d)
cd "$nps_dir"
NPS_RELEASE_NUMBER=${NPS_VERSION/beta/}
NPS_RELEASE_NUMBER=${NPS_VERSION/stable/}
psol_url=https://dl.google.com/dl/page-speed/psol/${NPS_RELEASE_NUMBER}.tar.gz
[ -e scripts/format_binary_url.sh ] && psol_url=$(scripts/format_binary_url.sh PSOL_BINARY_URL)
wget ${psol_url}
tar -xzvf $(basename ${psol_url})

cd $BASEDIR

NGX_DIR=$(find . -maxdepth 1 -name "nginx*" -type d)

mkdir -p $NGX_DIR/debian/modules/pagespeed

cp -r "$nps_dir"/!(*.tar.gz) "$NGX_DIR/debian/modules/pagespeed"

echo "debian/modules/pagespeed/psol/lib/Release/linux/x64/pagespeed_js_minify" > "$NGX_DIR/debian/source/include-binaries"

echo "load_module modules/ngx_pagespeed.so;" > "$NGX_DIR/debian/libnginx-mod.conf/mod-pagespeed.conf"

patch "$NGX_DIR/debian/rules" -i "$BASEDIR/patches/rules.patch"
patch "$NGX_DIR/debian/control" -i "$BASEDIR/patches/control.patch"

cp "$NGX_DIR/debian/libnginx-mod-mail.nginx" "$NGX_DIR/debian/libnginx-mod-pagespeed.nginx"

patch "$NGX_DIR/debian/libnginx-mod-pagespeed.nginx" -i "$BASEDIR/patches/pagespeed.patch"

cd $NGX_DIR

dpkg-buildpackage
