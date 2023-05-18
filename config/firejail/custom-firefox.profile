# Firejail profile for firefox

# Unfortunately we have to disable the protocol whitelist because the interface
# needed for the yubikey cannot be named for firejail.
#protocol unix,inet,inet6
ignore nou2f

noblacklist ${HOME}/.cache/mozilla
noblacklist ${HOME}/.mozilla

mkdir ${HOME}/.cache/mozilla/firefox
mkdir ${HOME}/.mozilla
whitelist ${HOME}/.cache/mozilla/firefox
whitelist ${HOME}/.mozilla

whitelist ${HOME}/tmp/downloads

include firefox.profile
