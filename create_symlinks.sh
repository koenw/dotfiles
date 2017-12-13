#!/usr/bin/env sh
#
# This script will create symlinks to the files in this dotfiles repo from
# their expected location in ${HOME}.
#
# Since there are currently ony two locations to create symlinks in
# ($HOME/<name> or $HOME/.config/<name>), there are simply to lists: `files` to
# configure the symlinks to $HOME/<name>, and `dot_config_dirs` for the
# symlinks to $HOME/.config/<name>.
#
# TODO:
# * perhaps use a hash for symlink -> target configuration
# * create a backup (perhaps to DOTFILES_DIR/backup which would be in
#   .gitignore) instead of just rm-ing

set -eu

# Defaults
#
## Files directly in $HOME to create symlinks to.
#files=(gnupg htoprc tmux.conf vimrc vim tmux.conf Xresources zshrc zsh.d xinitrc gitconfig)
files=(htoprc tmux.conf vimrc vim tmux.conf Xresources zshrc zsh.d xinitrc gitconfig gtkrc-2.0 krb5.conf)
## Directories in ${HOME}/.config to create symlinks to
dot_config_dirs=(awesome)
## Don't prompt before removing current file
FORCE=false
## The target dir can be relative to $HOME
DOTFILES_DIR=".dotfiles"

while [[ $# -gt 0 ]]; do
	case "$1" in
		-f|--force)
			FORCE=true
			shift
			;;
		-d|--dotfiles)
			DOTFILES_DIR=$2
			shift
			shift
			;;
		*)
			echo "Unknown option" >/dev/stderr
			exit 1
			;;
	esac
done

create_symlink() {
  target="$1"
  name="$2"
  force="${FORCE=false}"

	# `test` follows symlink, so we'll have to check this way
	if ls "$name" >/dev/null 2>&1; then
		if "$force"; then
			rm -rf "$name"
		else
			rm -ri "$name"
		fi
	fi

	ln -s "$target" "$name"
}

# Create the $HOME/<name> symlinks
cd "$HOME"
for file in ${files[@]}; do
  target="${DOTFILES_DIR}/${file}"
	name="${HOME}/.${file}"

  create_symlink "$target" "$name"
done

# Create the $HOME/.config/<name> symlinks
test -d "${HOME}/.config" || mkdir "${HOME}/.config"
cd "${HOME}/.config"
for dir in ${dot_config_dirs[@]}; do
  target="../${DOTFILES_DIR}/${dir}"
  name="${HOME}/.config/${dir}"

  create_symlink "$target" "$name"
done
