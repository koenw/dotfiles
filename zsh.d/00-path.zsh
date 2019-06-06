for dir in /usr/bin /usr/sbin /sbin /bin /usr/local/bin /usr/local/sbin; do
  if test -d "$dir" && ! grep -q -e "^${dir}:" -e ":${dir}:" -e ":${dir}" <<< $PATH; then
    PATH="${PATH}:${dir}"
  fi
done
PATH="${HOME}/.bin:$PATH"
export PATH
