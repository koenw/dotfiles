#!/bin/sh

urxvtd &
xset b off &                    # no audio bell
numlockx &
xrdb -merge ~/.Xresources &
setxkbmap -option compose:ralt

pgrep redshift &> /dev/null || redshift -t 6500:3500 &> /dev/null &

pgrep unclutter &> /dev/null || unclutter &> /dev/null &

pasystray &> /dev/null &
blueberry-tray &> /dev/null &

xmodmap ~/.Xmodmap &

xset s 600 660
xset dpms 660 660 660
xss-lock -n ~/.bin/fade-to-lock.sh -- i3lock -c 000000 &

(while true; do
  cur_timeout=$(xset q |awk '/timeout:/ {print $2}')

  if pactl list sink-inputs |grep -qE '^\s+Corked: no$'; then
    # There is currently something playing, let's disable the screensaver
    if test $cur_timeout -ne 0; then
      xset s off
      xset -dpms
      echo "Disabled screensaver"
    fi
  else
    # There is currently nothing playing, let's make sure the screensaver
    # is enabled
    if test $cur_timeout -eq 0; then
      xset s 600 660
      xset +dpms
      echo "Enabled screensaver"
    fi
  fi

  sleep 60
done) &

exec awesome
