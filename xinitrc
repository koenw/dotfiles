#!/bin/sh

urxvtd &
xset b off &                    # no audio bell
numlockx &
xrdb -merge ~/.Xresources &
xautolock -time 5 -locker 'xset dpms force off' -killer 'i3lock -c 000000' -killtime 10 &
#syndaemon -k -d &
setxkbmap -option compose:ralt  # use right alt for special characters
setxkbmap -option caps:escape   # bind CapsLock to Escape

exec awesome