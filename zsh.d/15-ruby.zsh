for dir in ~/.rbenv/bin ~/.rbenv/shims ~/.gem/ruby/*/bin(oc); do
  if test -d "$dir"; then
    export PATH="${PATH}:${dir}"
  fi
done
