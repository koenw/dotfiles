# vim: foldmethod=marker syntax=zsh
# {{{ default arguments
if [[ `uname` == "FreeBSD" ]]; then
  alias ls='ls -F'
else
  alias ls='ls -F --color=auto'
fi
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -ltrh'
alias mv='mv -iv'
alias cp='cp -iva'
alias vi='vim'
alias scp='scp -o cipher=blowfish'

alias find='noglob find'
alias slocate='noglob slocate'
alias locate='noglob locate'
alias mlocate='noglob mlocate'

alias top='htop'

alias vimm='vim -c NotMuch'
# }}}

# {{{ shortcuts
alias burn='cdrecord -v speed=4 dev=/dev/cdrom'
# }}}

# {{{ Global aliases
alias -g L='|less'
alias -g G='|grep'
alias -g T='|tail'
# }}}

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
