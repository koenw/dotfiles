if ls --color=auto >&/dev/null; then
  alias ls='ls -F --color=auto'
else
  alias ls='ls -F'
fi

if which exa >/dev/null; then
  alias exa='exa -l --sort=modified --git'
  alias ll='exa'
else
  alias ll='ls -ltrh'
fi

if grep --color=auto >&/dev/null; then
  alias grep='grep --color=auto'
  alias egrep='egrep --color=auto'
fi

if which rg > /dev/null; then
  alias rg='rg -S'
fi

if which nvim > /dev/null; then
  alias vi='nvim'
elif which vim > /dev/null; then
  alias vi='vim'
fi

if which jexec >/dev/null; then
  alias jexec='jexec -l'
fi

alias find='noglob find'
alias git='noglob git'
alias py='python3'

# Facilitate a pretty, sudo-aware shell prompt by exposing some env vars.
alias sudo='sudo --preserve-env=SSH_CLIENT,SSH_CONNECTION,SSH_TTY'

alias yt-dl='docker run --rm -i -e PGID=$(id -g) -e PUID=$(id -u) -v "$(pwd)":/workdir:rw mikenye/youtube-dl'

function mkalbum() { mkdir "$(date +%Y%m%d)_${1}" }

function qr() {
  local f=$(mktemp)
  qrencode -o $f -- "$*" && imv $f
  rm $f
}
