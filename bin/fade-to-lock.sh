#!/usr/bin/env bash

# xss-lock notifier to dim the screen before locking it after inactivity.

# Brightness will be lowered to this value.
min_brightness=0
fade_time=10
fade_steps=300

get_brightness() {
  light
}

set_brightness() {
   light -S $1
}

fade_brightness() {
  for s in `seq $(light) -1 0`; do
    light -S $s
    sleep 0.05
  done
}

trap 'exit 0' TERM INT
trap "set_brightness $(get_brightness); kill %%" EXIT

fade_brightness $min_brightness
sleep infinity &
wait
