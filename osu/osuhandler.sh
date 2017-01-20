#!/bin/bash

#echo passed arguments to log
echo $@ >> /home/atomsk/.osu/handler.log

#Execute osu!\.exe in correct wine prefix and append uri 
#$@ is the variable which stores all passed arguments
WINEPREFIX=~/.osu wine ~/osu\!/osu\!.exe $@

