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

if which rg > /dev/null; then
  alias rg='rg -S'
fi

if which nvim > /dev/null; then
  alias vi='nvim'
elif which vim > /dev/null; then
  alias vi='vim'
fi

if which bat >/dev/null; then
  alias cat='bat'
fi

if which jexec >/dev/null; then
  alias jexec='jexec -l'
fi

alias find='noglob find'
alias git='noglob git'
