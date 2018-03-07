#!/bin/sh

Mouse=`xinput list |grep -i ELECOM | awk -F= '{ print $2}'| awk '{print $1}'| awk 'BEGIN{ RS = "" ; FS = "\n" }{print $1}'`

xinput set-prop $Mouse "libinput Middle Emulation Enabled" 1
xinput set-prop $Mouse "libinput Scroll Method Enabled" 0, 0, 1
xinput set-button-map $Mouse 1 2 3 4 5 6 7 8 9 2 11 12
