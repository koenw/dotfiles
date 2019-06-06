function title {
   if [[ $TERM == "screen"* ]]; then
      # set tmux title
      printf '\033]2;%s\033\\' $1
      # set terminal title
      print -nR $'\033]0;'$1$'\a'
   else
      #print -nR $'\033]0;'$*$'\a'
      #print -nR $'\033k'$1$'\033\\'
   fi
}
function precmd {
   [[ $UID == 0 ]] && root="#"
   pwd=${PWD/$HOME/'~'}
   title "$USER@$HOST:$root$pwd"
}
function preexec {
   emulate -L zsh
   local -a cmd; cmd=(${(z)1})
   title "$USER@$HOST:$root $cmd[1]:t $cmd[2,-1]"
}
