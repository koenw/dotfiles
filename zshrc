#!/usr/bin/env zsh
# vim: foldmethod=marker syntax=zsh
#

# {{{ Autostart X
if [[ -x $(which startx) ]] && [[ $(tty) = /dev/tty1 ]] && [[ ! $UID = 0 ]]; then
  startx
  logout
fi
# }}}

# {{{ Autostart wayland (sway)
if [[ -x $(which sway) ]] && [[ $(tty) = /dev/tty1 ]] && [[ ! $UID = 0 ]]; then
  sway
  logout
fi
# }}}

# {{{ ENVIRONMENT
if which nvim >/dev/null; then
  export EDITOR=nvim
elif which vim >/dev/null; then
  export EDITOR=vim
else
  export EDITOR=vi
fi
export VISUAL=$EDITOR
export PAGER=less
# }}}

# {{{ Prompt & dircolors
if [[ $UID = 0 ]]; then
  export PS1='%B%{[31m%}%n %{[39m%}%m%{[39m%}:%{[36m%}%2c%{[39m%} [%{[33m%}%h%{[39m%}%1(j.%{[30m%}%%%j%{[39m%}.)%0(?..:%{[31m%}%?%{[39m%})]%#%b '
else
  export PS1='%B%{[39m%}%n %{[39m%}%m%{[39m%}:%{[36m%}%2c%{[39m%} [%{[33m%}%h%{[39m%}%1(j.%{[30m%}%%%j%{[39m%}.)%0(?..:%{[31m%}%?%{[39m%})]%#%b '
fi

if [[ -x `which dircolors` ]]; then
  eval `dircolors -b ~/.config/dircolors`   # sets LSCOLORS
else
  export CLICOLOR=1     # BSD ls
fi
# }}}

# {{{ user/shell I/O
# disable XON/XOFF flow control (^s/^q)
stty -ixon -ixoff
setopt no_flowcontrol
setopt interactive_comments
setopt autocd
setopt auto_pushd
setopt pushd_ignore_dups
export WORDCHARS="$(sed 's|/||' <<< $WORDCHARS)"
# }}}

# {{{ completion / globbing
setopt extendedglob
autoload -Uz compinit; compinit
zstyle ':completion:*' use-cache on
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' completer _complete _match _approximate
#zstyle ':completion:*' insert-unambiguous
#zstyle ':completion:*' file-sort time
zstyle ':completion:*' menu select
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle ':completion:*:match:*' original only
# }}}

# {{{ history
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000

setopt inc_append_history
setopt extended_history  # mainly save time details
setopt hist_find_no_dups
setopt hist_ignore_space
setopt hist_no_store # don't save history command
# }}}

# {{{ job control
setopt auto_continue # send CONT when disowning a job
setopt auto_resume # easy resume bg job
# }}}

# {{{ keybindings
bindkey -v
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M viins '^X' edit-command-line # in $EDITOR
bindkey '^L' push-line
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^U' kill-whole-line # kill from cursor to BOL
bindkey '^K' kill-line # kill from cursor to EOL
bindkey '^Y' yank # Yank the last killed item back from the stack
bindkey -M vicmd '^E' end-of-line
bindkey -M vicmd '^A' beginning-of-line
bindkey -M viins '^R' history-incremental-pattern-search-backward
bindkey -M viins '\e.' insert-last-word # Insert !!:$ on ALT-. (or ESC-.)
zle -A .backward-kill-word vi-backward-kill-word
zle -A .backward-delete-char vi-backward-delete-char
# }}}

# {{{ colored manpages
export LESS_TERMCAP_mb=$'\E[01;31m'   # begin blinking
export LESS_TERMCAP_md=$'\E[01;31m'   # begin bold
export LESS_TERMCAP_me=$'\E[0m'       # end mode
export LESS_TERMCAP_se=$'\E[0m'       # end standout-mode
export LESS_TERMCAP_so=$'\E[1;33;40m' # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'       # end underline
export LESS_TERMCAP_us=$'\E[1;32m'    # begin underline
# }}}

for f in ~/.zsh.d/*.zsh; do
  source "$f"
done
