#!/bin/bash

# require sudo
if [ $(id -u) != "0" ]; then
    echo "This script has to be run as sudo"
    exit
fi

usage() {
    echo "usage: install.sh [OPTION] SUBCOMMAND"
    echo "Possible Options:"
    echo "   -l      | list all programs and files that will be installed with the selected mode"
    echo "   -h      | show this help message and exit"
    echo "Possible subcommands:"
    echo "    full   | full installation (also runs apt upgrade)"
    echo "    custom | custom installation"
    echo "    min    | minimal installtion"
    exit
}

installTmuxCpuMemProgram() {
    git clone https://github.com/thewtex/tmux-mem-cpu-load.git tmuxLoad
    cd tmuxLoad
    cmake .
    make
    sudo make install
    cd ..
    rm -rf tmuxLoad
}

installUwUFetch() {
    git clone https://github.com/TheDarkBug/uwufetch.git
    cd uwufetch
    make build # add "CFLAGS+=-D__IPHONE__" if you are building for iOS
    sudo make install
    cd ..
    rm -rf uwufetch
}

installMin() {
    echo "[install.sh]-- updating sources"
    apt update &> /dev/null

    echo "[install.sh]-- Installing Git"
    apt install -y git &> /dev/null

    echo "[install.sh]-- Installing curl"
    apt install -y curl &> /dev/null

    echo "[install.sh]-- Installing VScode"
    snap install code &> /dev/null

    echo "[install.sh]-- Installing tmux"
    apt install -y tmux &> /dev/null

    echo "[install.sh]-- Installing tmux cpu and memory program"
    installTmuxCpuMemProgram &> /dev/null

    echo "[install.sh]-- Installing zsh"
    apt install -y zsh  &> /dev/null
    chsh -s $(which zsh) &> /dev/null

    echo "[install.sh]-- Installing omz"
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" &> /dev/null

    echo "[install.sh]-- Installing python3"
    apt install -y python3 &> /dev/null
    apt install -y python3-pip &> /dev/null
}

installFull() {
    echo "[install.sh]-- upgrading system"
    apt upgrade -y &> /dev/null

    echo "[install.sh]-- Installing UwUFetch"
    installUwUFetch &> /dev/null

    echo "[install.sh]-- Installing Neofetch"
    apt install -y neofetch &> /dev/null

    echo "[install.sh]-- Installing htop"
    apt install -y htop &> /dev/null

    echo "[install.sh]-- Installing nyancat"
    apt install -y nyancat &> /dev/null
}

linkMin() {
    echo "[install.sh]-- Linking .gitconfig"
    ln -s $(pwd)/.gitconfig ~/.gitconfig

    echo "[install.sh]-- Linking .vscode"
    ln -s $(pwd)/VScode/settings.json ~/.config/Code/User/settings.json
    ln -s $(pwd)/VScode/snippets ~/.config/Code/User/snippets

    echo "[install.sh]-- Linking .tmux.conf"
    ln -s $(pwd)/.tmux.conf ~/.tmux.conf

    echo "[install.sh]-- Linking .zshrc"
    ln -s $(pwd)/.zshrc ~/.zshrc
    ln -s $(pwd)/.fzf.zsh ~/.fzf.zsh
    ln -s $(pwd)/cute.zsh-theme ~/.oh-my-zsh/themes/cute.zsh-theme

    echo "[install.sh]-- Linking ssh config"
    ln -s $(pwd)/Uni/sshConfig ~/.ssh/config
}

linkFull() {
    echo "[install.sh]-- full installation does not need linking currently"
}


installType=""
list=0

# Option for minimal, custom, full install
# TODO: Option for version and verbosity

while getopts :h:l flag; do
    case "${flag}" in
    h) usage ;;
    l) list=1 ;;
    *) usage ;;
    esac
done

ARG1=${@:$OPTIND:1}

case "$ARG1" in
minimal) installType="minimal" ;;
custom)
    installType="custom"
    echo "TODO: This feature is not implemented yet."
    exit 1
    ;;
full) installType="full" ;;
*) usage ;;
esac

if [ $list == 1 ]; then
    echo "List of all programs and files installed by selected mode: $installType"
fi

echo "Install Type: $installType"

installMin
if [ $installType == "full" ]; then
    installFull
    linkFull
fi
linkMin
