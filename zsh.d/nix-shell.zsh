source ~/.zsh.d/nix-shell/nix-shell.zsh
test -n "$IN_NIX_SHELL" && export RPROMPT="[%F{yellow}${name}%f]"
