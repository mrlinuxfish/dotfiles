#!/bin/sh

# Combined startup script for kde

# Start whatpulse minimized
whatpulse --closedwindow --delaystartup &
echo "whatpulse is up"

# Steam
sh -c 'STEAM_FRAME_FORCE_CLOSE=1 steam -silent' &
echo "steam is up"

#Redshift
redshift &
echo "redshift started"

# Razer Naga keyboard definitions
# bind naga keys so they will not produce multiple keystrokes (using F15 seems to be effective, but could have adverse side effects)
remote_id=$(
  xinput list |
  sed -n 's/.*Naga.*id=\([0-9]*\).*keyboard.*/\1/p'
)
[ "$remote_id" ] || exit

mkdir -p /tmp/xkb/symbols
cat >/tmp/xkb/symbols/custom <<\EOF
xkb_symbols "remote" {

    include "us"

    key <AE01>   { [Escape] };
    key <AE02>   { [Home] };
    key <AE03>   { [End] };
    key <AE04>   { [F15] };
    key <AE05>   { [F15] };
    key <AE06>   { [F15] };
    key <AE07>   { [F15] };
    key <AE08>   { [F15] };
    key <AE09>   { [F15] };
    key <AE10>   { [] };
    key <AE11>   { [] };
    key <AE12>   { [] };
};
EOF

setxkbmap -device $remote_id -print | sed 's/\(xkb_symbols.*\)"/\1+custom(remote)"/' | xkbcomp -I/tmp/xkb -i $remote_id -synch - $DISPLAY 2>/dev/null

echo "naga keys defined"

# Naga daemon (keymapper)
naga &
echo "naga started"

# Remove shadows
# Wait 10 seconds so the taskbar is drawn first
#/bin/sleep 10

#Removes shadow from only taskbar

# for WID in $(xwininfo -root -tree | sed '/"Plasma": ("plasmashell" "plasmashell")/!d; s/^  *\([^ ]*\) .*/\1/g'); do
#    xprop -id $WID -remove _KDE_NET_WM_SHADOW
# done

