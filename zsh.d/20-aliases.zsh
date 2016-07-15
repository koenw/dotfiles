if ls --color=auto >&/dev/null; then
  alias ls='ls -F --color=auto'
else
  alias ls='ls -F'
fi
alias ll='ls -ltrh'

if grep --color=auto >&/dev/null; then
  alias grep='grep --color=auto'
  alias egrep='egrep --color=auto'
fi

if which vim > /dev/null; then
  alias vi='vim'
fi

alias find='noglob find'
alias git='noglob git'
