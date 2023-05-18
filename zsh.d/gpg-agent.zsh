if which gpg >/dev/null 2>&1; then
  export GPG_TTY=$(tty)
  export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  # We don't export e.g. SSH_AUTH_SOCK here, because the gpg-agent will only be
  # used as ssh-agent for some some but not all hosts/keys. The ssh_config will
  # point to the relevant socket.
  pgrep -u "$USER" gpg-agent >/dev/null || gpg-agent --daemon --enable-ssh-support > ~/.gpg-agent-env

  function gpg() {
    gpg-connect-agent UPDATESTARTUPTTY /bye >/dev/null;
    eval $(type -p gpg |awk '{print $3}') $*
  }
fi
