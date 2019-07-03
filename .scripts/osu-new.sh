#!/bin/sh
export WINEPREFIX="$HOME/.osu"
export STAGING_AUDIO_DURATION=5000 # As low as you can get osu! stable with

# Arch Linux/wine-osu users should uncomment next line
# for the patch to be effective
#export PATH=/opt/wine-osu/bin:$PATH

cd ~/osu!/ # Or wherever you installed osu! in
wine osu!.exe "$@"
