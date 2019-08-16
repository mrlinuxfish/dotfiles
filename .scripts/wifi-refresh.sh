#!/bin/sh

# Disable wifi
netctl-auto disable-all

# Enable wifi again
netctl-auto enable-all
