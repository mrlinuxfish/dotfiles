#!/bin/sh

# xrandr command to scale output over hdmi to mirror laptop screen
xrandr --output LVDS-1 --mode 1366x768 --output HDMI-1 --scale-from 1366x768 --same-as LVDS-1

