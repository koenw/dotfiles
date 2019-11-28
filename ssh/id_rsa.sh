#!/usr/bin/env sh

keyfile=$(sed 's/\.sh$//' <<< $0)
pass show "ssh/$(basename $keyfile)" | head -n 1
