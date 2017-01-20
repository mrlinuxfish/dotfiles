#!/bin/bash

#Wait 10 seconds so the taskbar is drawn first
/bin/sleep 10

#Removes shadow from only taskbar

for WID in $(xwininfo -root -tree | sed '/"Plasma": ("plasmashell" "plasmashell")/!d; s/^  *\([^ ]*\) .*/\1/g'); do
   xprop -id $WID -remove _KDE_NET_WM_SHADOW
done

