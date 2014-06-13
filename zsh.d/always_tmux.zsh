if [[ "$TERM" == screen* ]] || [[ -n "$TMUX" ]]; then
  return 1
fi

if tmux list-sessions && (tmux list-sessions | test -n "$0"); then
  session_id=`date +%Y%m%d%H%M%S`
  tmux new-session -d -t base -s $session_id
  tmux attach-session -t $session_id \; set-option destroy-unattached
else
  tmux new-session -s base
fi
