function ssltelnet() {
  openssl s_client -connect $1:$2
}
