dbus-update-activation-environment --systemd DISPLAY
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
xrdb -merge .Xresources
setxkbmap -layout "us,rs(latin),rs" -option grp:shifts_toggle
xset -b
/usr/bin/xmonad
