if which gpg >/dev/null 2>&1; then
  export GPG_TTY=$(tty)
  export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  pgrep -u "$USER" gpg-agent >/dev/null || gpg-agent --daemon --enable-ssh-support > ~/.gpg-agent-env

  function gpg() {
    # Let the gpg-agent know on which tty we are in case the pinentry-program
    # needs to ask us some private questions.
    gpg-connect-agent UPDATESTARTUPTTY /bye >/dev/null &;
    eval $(type -p gpg |awk '{print $3}') $*
  }
fi
