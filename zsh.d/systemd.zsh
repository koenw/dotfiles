start() {
  systemctl start $@
}

stop() {
  systemctl stop $@
}

restart() {
  systemctl restart $@
}

status() {
  systemctl status $@
}
