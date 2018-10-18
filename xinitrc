#!/bin/sh

urxvtd &
xset b off &                    # no audio bell
numlockx &
xrdb -merge ~/.Xresources &
xmodmap ~/.xmodmap
setxkbmap -option compose:ralt

pgrep redshift &> /dev/null || redshift -t 6500:3500 &> /dev/null &

pgrep unclutter &> /dev/null || unclutter &> /dev/null &

exec awesome
