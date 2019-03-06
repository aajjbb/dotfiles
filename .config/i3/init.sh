#!/usr/bin/bash

# define background color
xsetroot -solid "#000000"

# compositor manager
# compton &

# init network-manager
kcmshell5 kcm networkmanager

# adjusts screen color temperature
redshift &
