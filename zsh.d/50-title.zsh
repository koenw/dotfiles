function title {
   if [[ $TERM == "screen"* ]]; then
      print -nR $'\033k'$1$'\033\\'
      print -nR $'\033]0;'$2$'\a'
   else
      #print -Pn "\e]0;%n@%m: %~\a"
      #print -Pn "\e]0;$1\a"
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
