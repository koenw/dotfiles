for dir in ~/.rbenv/bin ~/.rbenv/shims ~/.gem/ruby/*/bin(ocN); do
  if test -d "$dir"; then
    export PATH="${PATH}:${dir}"
  fi
done
