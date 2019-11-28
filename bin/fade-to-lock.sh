#!/bin/bash

# xss-lock notifier to dim the screen before locking it after inactivity.

# Brightness will be lowered to this value.
min_brightness=0
fade_time=5000
fade_steps=300

get_brightness() {
  xbacklight -get
}

set_brightness() {
  xbacklight -steps 1 -set $1
}

fade_brightness() {
  xbacklight -time $fade_time -steps $fade_steps -set $1
}

trap 'exit 0' TERM INT
trap "set_brightness $(get_brightness); kill %%" EXIT
fade_brightness $min_brightness
sleep infinity &
wait
