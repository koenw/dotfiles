#!/bin/sh

urxvtd &
xset b off &                    # no audio bell
numlockx &
xrdb -merge ~/.Xresources &
#pgrep xautolock &>/dev/null || xautolock -time 5 -locker 'xset dpms force off' -killer 'i3lock -c 000000' -killtime 10 &
#syndaemon -k -d &
setxkbmap -option compose:ralt  # use right alt for special characters
setxkbmap -option caps:escape   # bind CapsLock to Escape

pgrep redshift &> /dev/null || redshift -t 6500:3500 &> /dev/null &

pgrep unclutter &> /dev/null || unclutter &> /dev/null &

exec awesome
