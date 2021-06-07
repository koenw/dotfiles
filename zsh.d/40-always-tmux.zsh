if [[ "$TERM" == screen* ]] || [[ -n "$TMUX" ]]; then
  return 1
fi

animals=(🐈 🦄 🐮 🐖 🐽 🐗 🐪 🦙 🦘 🦒 🦏 🦛 🐹 🦔 🦇 🐨 🦃 🐦 🦆 🦉 🐸 🦜 🦚 🦩 🐙 🐛 🐝 🦠 🐝 🐡 🦖 🐊)

if tmux list-sessions |grep -e '.'; then
  # There is at least one tmux session running. We'll take the oldest, and
  # create a new session in the same group (so all windows are available from
  # all clients)
  current_session_id=$(tmux list-sessions |tail -n 1 |awk -F: '{print $1}')
  new_session_id=${animals[RANDOM % $#animals + 1]}
  tmux new-session -d -t $current_session_id -s $new_session_id
  tmux attach-session -t $new_session_id \; set-option destroy-unattached
else
  tmux new-session -s ${animals[RANDOM % $#animals + 1]}
fi
