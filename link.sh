#!/usr/bin/env sh
#
# Create symlinks from the various location in $HOME to the corresponding files
# and directories in this repo.
#
# Every file or directory in the root of this repo that is not in the
# `.linkignore` file will be linked to by a symlink in $HOME, with a `.`
# prepended to the link name. E.g., a symlink will be created from
# `$HOME/.zsh.d` to `zsh.d` in this repo.

set -euo pipefail

DEBUG=false
VERBOSE=false
REPO=$(dirname $(realpath $0))
TIMESTAMP=$(date --rfc-3339=seconds |sed 's/ /_/g')

# Print the help message and exit.
function usage() {
cat <<EOF
$0: Create symlinks to the files and directories in this repo.

Every file or directory in the root of this repo that is not matched by a line
in the '.linkignore' file will be linked to be a symlink in \$HOME, with a '.'
prepended to the link name. E.g. a symlink would be created from '$\HOME/.zsh.d'
to zsh.d in this repo. Lines in '.linkignore' are matched by (grep) regex.

If a file or directory is already present where we want to create our symlink,
it is moved to the 'backup' directory.

Usage: $0 [options]

Options:
-h, --help     Print this message and exit
-v, --verbose  Be more verbose
-d, --debug    Print debugging info
EOF
}

# Print arguments if $DEBUG is true.
function debug() { if $DEBUG; then echo $*; fi }

# Print arguments if $VERBOSE is true.
function msg() { if $VERBOSE; then echo $*; fi }

# Receives a directory as an argument, and creates symlinks to the
# files/directories in that directory.
function process_root() {
  local root=$1
  ORIG_IFS=$IFS
  IFS=$(echo -en "\n\b")

  for path in ${root}/*; do
    relname=$(realpath -s --relative-to="${REPO}" "$path")
    if echo $relname | grep -qxEf "${REPO}/.linkignore"; then
      debug "Ignoring $path"
      test -d "$path" && process_root "$path"
      continue
    fi

    create_symlink "$path" "${HOME}/.${relname}"
  done

  IFS=$ORIG_IFS
}

# Creates a symlink from $2 to $1, after checking if $2 already exists and if
# so, backing it up.
function create_symlink() {
  local target=$1
  local target_dir=$(dirname $target)
  local name=$2
  local backup_dir="${REPO}/backup/${TIMESTAMP}"

  # If the target is also a symlink, resolve it first to prevent
  # false positives.
  test -L "$target" && target=$(realpath "$target")

  if test -L "$name" -a "$(realpath -m "$name")" == "$target"; then
    debug "Nothing to be done for $name"
    return
  fi

  if test -e "$name"; then
    msg "Moving $name to $backup_dir"
    mkdir -p "$backup_dir" && mv "$name" "$backup_dir"
  elif test -L "$name"; then
    rm "$name"
  fi

  mkdir -p "$target_dir"
  echo ln -s "$target" "$name"
  ln -s "$target" "$name"
}

while test $# -gt 0; do
  case $1 in
    -v|--verbose)
      VERBOSE=true
      shift
      ;;
    -d|--debug)
      DEBUG=true
      shift
      ;;
    -h|--help)
      usage
      exit 2
  esac
done

process_root $REPO
