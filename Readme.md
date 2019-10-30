# Pagespeed-builder

Script / Dockerfile for building a debian package containing [google pagespeed](https://developers.google.com/speed/pagespeed/module/) as a dynamic module for nginx.

# Build

For debian stretch:

`git clone git@github.com:mgit-at/pagespeed-builder.git`  
`cd pagespeed-builder && make`  

For building pagespeed with other versions of debian / nginx change the
`CODENAME` variable inside the Makefile.
If you want an other version of pagepeed adjust the `VERSION` variable in the Makefile.
The resulting files will appear in a build folder.
