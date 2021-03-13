#!/usr/bin/bash

# define background color
xsetroot -solid "#000000"

# compositor manager
# compton &

# init network-manager on kde
kcmshell5 kcm networkmanager &

# init network-manager on gnome
nm-applet &

# Init emacs daemon
emacs --daemon

# adjusts screen color temperature
redshift &
