if which gpg >/dev/null 2>&1; then
  export GPG_TTY=$(tty)
  gpg-connect-agent /bye

  echo UPDATESTARTUPTTY | gpg-connect-agent >/dev/null
fi
