#!/bin/bash

## The purpose of this script is to backup old dotfiles and install dotfiles from the dotfiles directory ##
## this script is in progress ##

echo "the script is not finished :("

# Send input to $arg
arg=$1

# Parse input for build options
# cli = all command line tool configuration files

## Backup function to deal with stow issues
backup ()
{
# Define backup directory andd backup file
backupdir=""$(dirname "$0")"/backup/$backup"
backupfile=""$(dirname "$0")"/backup/$backup/file-list.old"

echo $backup
echo $backupdir $backupfile

# make backup directory
mkdir -p $backupdir
echo "backup directory made"

# make backup tracking file
touch $backupfile

# add stow conflict locations to tracking file
stow -n $backup |& awk '/existing/ {print $NF}' | cat > $backupfile

# copy files to backup (cat command reads the entirety of $backupfile and outputs each line to cp)
#cp `cat $backupfile` $backupdir
}

while [[ $# -gt 1 ]]
do
key=$1

case $key in
    -i|--install)
    install="$2"
    shift # past argument
    ;;
    -u|--uninstall)
    uninstall="$2"
    shift # past argument
    ;;
    -h|--help)
    helper="$2"
    shift # past argument
    ;;
    -u|--uninstall)
    install="$2"
    shift # past argument
    ;;
    -b|--backup)
    backup="$2"
    shift # past argument
    ;;
    *)
            # unknown option
    ;;
esac
shift # past argument or value
done

backup $backup
