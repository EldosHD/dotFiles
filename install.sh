#!/bin/bash

# require sudo
if [ `id -u` != "0" ]
then
    echo "This script has to be run as sudo"
    exit
fi


usage() {
    echo "test"
}

installType=""


# Todo:
# Option for minimal, custom, full install

ARG1=${@:$OPTIND:1}

case "$ARG1" in
    minimal) installType="minimal";;
    custom) installType="custom";;
    full) installType="full";;
    *) usage
esac

echo "$installType"


# Install:
# - Git
# - Emacs
# - Tmux
# - Zsh
