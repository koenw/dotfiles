function ssh() {
  setopt extendedglob
  keyLifetime=4h

  if ls ~/.ssh/id_rsa*~*.pub > /dev/null; then
    if ! ssh-add -l > /dev/null; then
      ssh-add -t $keyLifetime ~/.ssh/id_rsa*~*.pub
    fi
  fi

  eval TERM=screen `/usr/bin/which ssh` $*
}
