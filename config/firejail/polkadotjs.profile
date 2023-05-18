# Firejail profile for riot-desktop

seccomp !chroot

noblacklist ${HOME}/.config/polkadot-apps/polkadot-accounts
mkdir ${HOME}/.config/polkadot-apps/polkadot-accounts
whitelist ${HOME}/.config/polkadot-apps/polkadot-accounts

whitelist ${HOME}/tmp/downloads

# Redirect
include electron.profile
