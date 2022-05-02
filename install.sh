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
    echo "   -l      | list all programs and files that will be installed with the selected mode"
    echo "   -h      | show this help message and exit"
    echo "Possible subcommands:"
    echo "    full   | full installation"
    echo "    custom | custom installation"
    echo "    min    | minimal installtion"
    exit
}

installType=""
list=0

# Option for minimal, custom, full install
# TODO: Option for version and verbosity

while getopts :h:l flag
do
    case "${flag}" in
	h) usage ;;
	l) list=1 ;;
	*) usage ;;
    esac
done



ARG1=${@:$OPTIND:1}

case "$ARG1" in
    minimal) installType="minimal";;
    custom)
	installType="custom"
	echo "TODO: This feature is not implemented yet."
	exit 1
	;;
    full) installType="full";;
    *) usage ;;
esac

if [ $list == 1 ]
then
    echo "List of all programs and files installed by selected mode: $installType"
fi

echo "Install Type: $installType"

# lsp mode for emacs
# pip install 'python-language-server[all]'


# TODOOOO: Install:
# - Git
# - Emacs
# - Tmux
# - Zsh
