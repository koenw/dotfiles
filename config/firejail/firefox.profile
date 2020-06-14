# Firejail profile for firefox

# Persistent local custimizations
include firefox.local

# Persistent global definitions
include globals.local

noblacklist ${HOME}/.cache/mozilla
noblacklist ${HOME}/.mozilla

mkdir ${HOME}/.cache/mozilla/firefox
mkdir ${HOME}/mozilla
whitelist ${HOME}/.cache/mozilla/firefox
whitelist ${HOME}/mozilla

whitelist ${HOME}/tmp/downloads

include firefox-common.profile
