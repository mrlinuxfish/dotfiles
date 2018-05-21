#!/bin/bash

#kill pulse audio
pulseaudio -k

#restart pulse audio
pulseaudio --start
