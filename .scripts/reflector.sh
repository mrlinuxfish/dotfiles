#!/bin/sh

# Synchronize to the fastest Arch Linux servers
sudo reflector --latest 200 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist
