if ! setopt | egrep -q '^extendedglob'; then
  setopt extendedglob
  resetglob='yes'
fi

if ls ~/.ssh/id_rsa*~*.pub; then
  eval `keychain --eval --nogui --ignore-missing -Q -q --agents ssh,gpg --noask ~/.ssh/id_rsa*~*.pub`
  if [[ $resetglob == 'yes' ]]; then
    setopt noextendedglob
  fi
fi > /dev/null 2>&1
