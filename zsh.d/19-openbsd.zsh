if [[ $(uname) == 'OpenBSD' ]]; then
  PKG_PATH="ftp://ftp.openbsd.org/pub/OpenBSD/$(uname -r)/packages/$(uname -m)"
fi
export PKG_PATH
