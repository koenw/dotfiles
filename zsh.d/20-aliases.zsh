if ls --color=auto >&/dev/null; then
  alias ls='ls -F --color=auto'
else
  alias ls='ls -F'
fi

alias exa='exa -l --sort=modified --git'
if which exa >/dev/null; then
  alias ll='exa'
else
  alias ll='ls -ltrh'
fi

if grep --color=auto >&/dev/null; then
  alias grep='grep --color=auto'
  alias egrep='egrep --color=auto'
fi

if which nvim > /dev/null; then
  alias vi='nvim'
elif which vim > /dev/null; then
  alias vi='vim'
fi

alias find='noglob find'
alias git='noglob git'
