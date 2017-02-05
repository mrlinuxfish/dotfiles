emulate sh -c 'source /etc/profile'

## run startx on tty1 when logging in
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
startx
fi

## add ability for using bspwm panel
export PANEL_FIFO=/tmp/panel-fifo

