#!/bin/sh
dbus-update-activation-environment --systemd DISPLAY
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
xrdb -merge ~/.Xresources
xsetroot -solid black
#display -window root $(ls -d $HOME/data/image/* | shuf -n 1)
xscreensaver -no-splash &
xset -b
/usr/bin/xmonad
