#!/bin/bash
scrot /tmp/screenshot.png
convert /tmp/screenshot.png -blur 0x4 /tmp/screenshotblur.png
i3lock -f -i /tmp/screenshotblur.png
