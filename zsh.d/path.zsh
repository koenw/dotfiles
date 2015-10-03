for dir in /usr/bin /usr/sbin /sbin /bin; do
  if test -d "$dir" && ! grep -q -e "^${dir}:" -e ":${dir}:" -e ":${dir}" <<< $PATH; then
    PATH="${dir}:${PATH}"
  fi
done
export PATH
