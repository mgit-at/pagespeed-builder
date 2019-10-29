#!/bin/bash

NPS_VERSION="$1"
if [ -z "$NPS_VERSION" ]; then
    echo "Usage: $0 <pagespeed-version>"
    exit 1
fi

set -x -e -u
shopt -s extglob

BASEDIR=$(pwd)
FILESDIR=$(realpath "${BASH_SOURCE%/*}/files")

# Get nginx pagespeed
cd $BASEDIR
wget https://github.com/apache/incubator-pagespeed-ngx/archive/v${NPS_VERSION}.zip
unzip v${NPS_VERSION}.zip
nps_dir=$(find . -name "*pagespeed-ngx-${NPS_VERSION}" -type d)
cd "$nps_dir"
nps_release_number=${NPS_VERSION/beta/}
nps_release_number=${NPS_VERSION/stable/}
psol_url=https://dl.google.com/dl/page-speed/psol/${nps_release_number}.tar.gz
[ -e scripts/format_binary_url.sh ] && psol_url=$(scripts/format_binary_url.sh PSOL_BINARY_URL)
wget ${psol_url}
tar -xzvf $(basename ${psol_url})

# Get nginx source
cd $BASEDIR
apt-get source nginx

# Add pagespeed to nginx source
ngx_dir=$(find . -maxdepth 1 -name "nginx*" -type d)
mkdir -p $ngx_dir/debian/modules/pagespeed
rm "$nps_dir"/*.tar.gz
cp -r "$nps_dir"/* "$ngx_dir/debian/modules/pagespeed"

# Prepare nginx source for compilation with pagespeed
cd $ngx_dir

echo "debian/modules/pagespeed/psol/lib/Release/linux/x64/pagespeed_js_minify" > debian/source/include-binaries
echo "load_module modules/ngx_pagespeed.so;" > debian/libnginx-mod.conf/mod-pagespeed.conf
cp "$FILESDIR/libnginx-mod-pagespeed.nginx" debian/
patch -p1 < "$FILESDIR/debian.patch"

exec dpkg-buildpackage
