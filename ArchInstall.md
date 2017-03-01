# Arch Install Docs v2 #

## Install Packages ##
- gvim
- emacs
- git

## Pre-reboot ##
- Install packages: `base basedevel git htop zsh tmux xorg-server sudo`
- Configure systemd-boot options
- Install systemd-boot on /esp (efi system partition)
- Add password to root: `passwd root`
- Add new user: `useradd -m -g users -G wheel -s /bin/zsh [username]`
- Change your new user's password: `passwd [username]`
- Use `visudo` to uncomment user group wheel
- If running wifi install: wifi-menu
- Install Desktop Environment / Window Manager
- Optional: Install login manager
- Use systemd to add login manager to startup: `systemctl enable [loginmanager.service]`

## Post reboot ##
- Login to system (duh)
- Install dependencies for packer: `pkgconfig`
- Install packer from aur: `curl [packer package url]`, unzip package, cd into package, `makepkg`, `pacman -U [package]`
- Download dotfiles from git

## Nvidia specific stuff ##
- Install: `nvidia-dkms` driver package

## Window Managers: ##

### Bspwm specific stuff ###
- Install: `bspwm sxhkd termite`
- Install: from aur: `polybar`
- Install `feh` to set background image
- Install `udisks2 ntfs-3g dosfstools exfat-utils` for filesystem management
- Install `xorg-xprop xdotool xorg-xwebinfo` for bspwm scratchpad

### KDE specific stuff ###
- Install: kde package `xfce-terminal`
- Install from aur: `kcm-wacomtablet`

### Power management ###
- Install `tlp ethtool lsb-release smartmontools x86_energy_perf_policy`
- Disable systemd-rfkill.service (if applicable) `systemctl mask systemd-rfkill.service`
- Enable tlp.service and tlp-sleep.service `systemctl enable tlp.service` `systemctl enable lp-sleep.service`

### SSH ###
- Install `openssh`

### Serial ###
- Install `screen`
- Add user to uucp group `gpasswd -a [user] uucp`
