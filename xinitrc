#!/bin/sh

urxvtd &
xset b off &                    # no audio bell
numlockx &
xrdb -merge ~/.Xresources &
setxkbmap -option compose:ralt

pgrep redshift &> /dev/null || redshift -t 6500:3500 &> /dev/null &

pgrep unclutter &> /dev/null || unclutter &> /dev/null &

xmodmap ~/.Xmodmap &

xset s 600 630
xss-lock -n ~/.bin/fade-to-lock.sh -- i3lock -c 000000 &

exec awesome
