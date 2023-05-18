function k() {
  if test -n "$KUBECTL_NS"; then
    ns_args="-n$KUBECTL_NS"
  else
    ns_args=""
  fi;
  kubectl $ns_args $*
}
