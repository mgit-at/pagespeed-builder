# Pagespeed-builder

Script / Dockerfile for building a debian package containing [google pagespeed](https://developers.google.com/speed/pagespeed/module/) as a dynamic module for nginx.

# Build

For debian/buster:

```
git clone https://github.com/mgit-at/pagespeed-builder.git
cd pagespeed-builder && make DISTRO=debian CODENAME=buster
```

If you want another version of pagepeed adjust the `VERSION` variable in the Makefile.
You may as well pass the variable when calling make:

```
make DISTRO=ubuntu CODENAME=bionic VERSION=1.2.3
```

The resulting files can be found in the folder `build/$VERSION/$DISTRO/$CODENAME/`
