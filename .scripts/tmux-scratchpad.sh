#!/bin/sh

# Define location of tmux-session-scratch.sh
tmux_session=~/.scripts/tmux-session-scratch.sh

# Start scratchpad running propper tmux session
pkill -f "termite -e $tmux_session --name dropdown"; termite -e ~/.scripts/tmux-session-scratch.sh --name dropdown
