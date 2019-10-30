# Pagespeed-builder

Script / Dockerfile for building google pagespeed as a dynamic module for nginx.

# Build

To build an installable libnginx-mod-pagespeed deb file you just have to clone this
repository, change the `DISTRO`, `CODENAME` and `VERSION` (pagespeed version) variables
in the Makefile according to your needs and then run `make`. After a successfull build
the resulting packages should appear in `build`.
