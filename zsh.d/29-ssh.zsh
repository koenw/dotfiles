# Start ssh-agent if it's not running yet
pgrep -u "$USER" ssh-agent >/dev/null || ssh-agent > ~/.ssh-agent-env
test -z "$SSH_AUTH_SOCK" && eval "$(<~/.ssh-agent-env)" >/dev/null

# This wrapper will make sure my favourite ssh keys are loaded.
function ssh() {
  local keyLifeTime=2h
  local keys_to_add=(koen@carb koen@koendalini)
  local added_keys=$(ssh-add -l |awk '{print $3}')

  for key in $keys_to_add; do
    if ! echo -e $added_keys | grep -q "$key"; then
      # Just add all the keys
      for key in ~/.ssh/id_*~*(.pub|.sh); do
        ssh-key-added "$key" || _ssh-add -t $keyLifeTime "$key"
      done
      break
    fi
  done

  eval $(type -p ssh |awk '{print $3}') $*
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
