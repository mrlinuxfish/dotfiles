#!/bin/sh

# Define location of tmux-session-scratch.sh
tmux_session=~/.scripts/tmux-session-scratch.sh

# Start scratchpad running propper tmux session
pkill -f "kitty --name dropdown $tmux_session"; kitty --name dropdown ~/.scripts/tmux-session-scratch.sh
