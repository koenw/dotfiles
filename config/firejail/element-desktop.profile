# Firejail profile for riot-desktop

seccomp !chroot

noblacklist ${HOME}/.config/Element
mkdir ${HOME}/.config/Element
whitelist ${HOME}/.config/Element

whitelist ${HOME}/tmp/downloads

whitelist ${HOME}/.config/Riot
whitelist ${HOME}/.config/Element

# Redirect
include riot-desktop.profile
