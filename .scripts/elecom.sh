#!/bin/sh

# Find all elecom pointer devices and iteratively apply the correct settings
# This will attempt to apply incorrect settings to some devices but this shouldn't be a problem
# for Trackball in `xinput list |awk -F= '/ELECOM.*pointer/ { print $2}' |awk '{ print $1}'`
# do
#     echo $Trackball
# xinput set-prop $Trackball "libinput Middle Emulation Enabled" 1
# xinput set-prop $Trackball "libinput Scroll Method Enabled" 0, 0, 1
# xinput set-prop $Trackball "libinput Accel Speed" .85
# xinput set-prop $Trackball "Coordinate Transformation Matrix" 1 0 0 0 1 0 0 0 2.6
# done
