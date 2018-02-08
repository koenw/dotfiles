function ssh() {
  keyLifeTime=2h

  for key in ~/.ssh/id_*~*.pub; do
    ssh-key-added "$key" || _ssh-add -t $keyLifeTime "$key"
  done

  eval TERM=screen `/usr/bin/which ssh` $*
}

# ssh-key-added takes the path to a ssh private key and checks if it's already
# in the ssh-agent.
function ssh-key-added() {
  local key="$1"
  ssh-add -l |awk '{print $3}' |grep -qw -- "$key"
}

# _ssh-add is a wrapper around ssh-add that uses ${key}.sh as SSH_ASKPASS.
function _ssh-add {
  local key=${@: -1}
  local askpass="${key}.sh"
  test -x "$askpass" || return 1
  cat /dev/null | SSH_ASKPASS="$askpass" ssh-add $*
}
