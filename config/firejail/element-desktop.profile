# Firejail profile for riot-desktop
# Description: A glossy Matrix collaboration client for the desktop
# This file is overwritten after every install/update
# Persistent local customizations
#include /etc/firejail/riot-desktop.local
# Persistent global definitions
# added by included profile
#include globals.local

seccomp !chroot

whitelist ${HOME}/tmp/downloads

# Redirect
include riot-web.profile
