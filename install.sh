#!/bin/bash

# require sudo
if [ `id -u` != "0" ]
then
    echo "This script has to be run as sudo"
    exit
fi


usage() {
    echo "usage: install.sh [OPTION] SUBCOMMAND"
    echo "Possible Options:"
    echo "   -t      | flag for testing"
    echo "   -h      | show this help message and exit"
    echo "Possible subcommands:"
    echo "    full   | full installation"
    echo "    custom | custom installation"
    echo "    min    | minimal installtion"
    exit
}

installType=""


# Todo:
# Option for minimal, custom, full install
while getopts :h:t flag
do
    case "${flag}" in
	h) usage ;;
	t) echo "test" ;;
	*) usage ;;
    esac
done



ARG1=${@:$OPTIND:1}

case "$ARG1" in
    minimal) installType="minimal";;
    custom) installType="custom";;
    full) installType="full";;
    *) usage ;;
esac


echo "Install Type: $installType"


# Install:
# - Git
# - Emacs
# - Tmux
# - Zsh
