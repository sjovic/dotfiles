#!/bin/sh
dbus-update-activation-environment --systemd DISPLAY
#eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
xrdb -merge ~/.Xresources
xsetroot -solid black
#display -window root $(ls -d $HOME/data/image/* | shuf -n 1)
#xscreensaver -no-splash &
xset -b
systemctl --user import-environment PATH DBUS_SESSION_BUS_ADDRESS
systemctl --no-block --user start xsession.target
#/usr/bin/redshift &
/usr/bin/xmonad
