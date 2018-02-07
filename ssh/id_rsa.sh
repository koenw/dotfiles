#!/usr/bin/env sh

keyfile=$(sed 's/\.sh$//' <<< $0)
pass show "personal/ssh/$(basename $keyfile)" | head -n 1
