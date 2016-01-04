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

# {{{ functions
extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1 ;;
      *.tar.gz)    tar xzf $1 ;;
      *.bz2)       bunzip2 $1 ;;
      *.rar)       unrar x $1 ;;
      *.gz)        gunzip $1 ;;
      *.tar)       tar xf $1 ;;
      *.tbz2)      tar xjf $1 ;;
      *.tgz)       tar xzf $1 ;;
      *.zip)       unzip $1 ;;
      *.Z)         uncompress $1 ;;
      *.7z)        7z x $1 ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}
# }}}
