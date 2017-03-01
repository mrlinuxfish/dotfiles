#!/bin/bash

## The purpose of this script is to backup old dotfiles and install 
## dotfiles from the dotfiles directory ##

## this script is in progress ##

echo "the script is not finished :("

## Backup function to deal with stow issues
function backup {
	
	# Define backup directory and backup file
	args=$@
	backupdir=""$(dirname "$0")"/backup/$args"
	backupfile=""$(dirname "$0")"/backup/$args/file-list.old"
	
	# make backup directory
	mkdir -p $backupdir
	
	# make backup tracking file
	touch $backupfile
	
	# add stow conflict locations to tracking file
	stow -n $@ |& awk '/existing/ {print $NF}' | cat > $backupfile
	
	# copy files to backup (cat command reads the entirety of $backupfile and outputs each line to cp)
	filename="$backupfile"
	while read -r line
	do
		mv ~/$line $backupdir
		echo $line
		echo "backing up:" $line
	done < "$filename"
}

function stowFiles {
	stow $@
}

## Define install groups
installTools="emacs git vim tmux zsh"
installDisplay="compton xrandr redshift"
installKde="kde"
installBspwm="bspwm compton"
installGames="osu"

## Get install options from user and run relevant procedures

while getopts bhiu option
do
	case "$option" in

		## Backup
		# Only backup conflicting files
		b) echo "backup"
		
		;;
		
		## Help
		# Print help information
		h) echo "help"
		
		;;

		## Install
		# backup and install installation group
		i) echo "i"
		
		;;

		## Uninstall
		# Un-stow and replace backed up files
		u) echo "u"
		
		;;

	esac
done
