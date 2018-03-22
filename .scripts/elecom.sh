#!/bin/sh

Mouse=`xinput list |grep -i ELECOM | awk -F= '{ print $2}'| awk '{print $1}'| awk 'BEGIN{ RS = "" ; FS = "\n" }{print $1}'`

xinput set-prop $Mouse "libinput Middle Emulation Enabled" 1
xinput set-prop $Mouse "libinput Scroll Method Enabled" 0, 0, 1
xinput set-prop $Mouse "libinput Accel Speed" .9
xinput set-prop $Mouse "Coordinate Transformation Matrix" .65 0 0 0 .65 0 0 0 3
