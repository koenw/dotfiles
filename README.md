# Dotfiles

My dotfiles.

## Populating $HOME with symlinks

You can use `link.sh` to create symlinks to the files and directories in this repo.

Every file or directory in the root of this repo that is not matched by a line
in the `.linkignore` file will be linked to be a symlink in `$HOME`, with a `.`
prepended to the link name. E.g. a symlink would be created from `$HOME.zsh.d`
to `zsh.d` in this repo. Lines in `.linkignore` are matched by (grep) regex.

If a file or directory is already present where we want to create our symlink,
it is moved to the 'backup' directory.

Usage: ./link.sh [options]

Options:
-h, --help     Print this message and exit
-v, --verbose  Be more verbose
-d, --debug    Print debugging info
