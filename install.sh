#!/bin/bash

# require sudo
if [ $(id -u) != "0" ]; then
    echo "This script has to be run as sudo"
    exit
fi

failedPackages=()
failedLinks=()

# TODO: add only link and only install options
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
    apt update &>/dev/null

    echo "[install.sh]-- Installing Git"
    if apt install -y git &>/dev/null; then
        echo "[install.sh]-- Git installed"
    else
        echo "[install.sh]-- Git installation failed"
        failedPackages+=("git")
    fi

    echo "[install.sh]-- Installing curl"
    if apt install -y curl &>/dev/null; then
        echo "[install.sh]-- curl installed"
    else
        echo "[install.sh]-- curl installation failed"
        failedPackages+=("curl")
    fi

    echo "[install.sh]-- Installing wget"
    if apt install -y wget &>/dev/null; then
        echo "[install.sh]-- wget installed"
    else
        echo "[install.sh]-- wget installation failed"
        failedPackages+=("wget")
    fi

    echo "[install.sh]-- Installing VScode"
    if sudo snap install code --classic &>/dev/null; then
        echo "[install.sh]-- VScode installed"
    else
        echo "[install.sh]-- VScode installation failed"
        failedPackages+=("vscode")
    fi 

    echo "[install.sh]-- Installing tmux"
    if apt install -y tmux &>/dev/null; then
        echo "[install.sh]-- tmux installed"
    else
        echo "[install.sh]-- tmux installation failed"
        failedPackages+=("tmux")
    fi

    echo "[install.sh]-- Installing tmux cpu and memory program"
    if installTmuxCpuMemProgram &>/dev/null; then
        echo "[install.sh]-- tmux cpu and memory program installed"
    else
        echo "[install.sh]-- tmux cpu and memory program installation failed"
        failedPackages+=("tmux cpu and memory program")
    fi

    echo "[install.sh]-- Installing zsh"
    if apt install -y zsh &>/dev/null; then
        echo "[install.sh]-- zsh installed"
    else
        echo "[install.sh]-- zsh installation failed"
        failedPackages+=("zsh")
    fi
    if chsh -s $(which zsh) &>/dev/null; then
        echo "[install.sh]-- zsh set as default shell"
    else
        echo "[install.sh]-- zsh could not be set as default shell"
        failedPackages+=("zsh")
    fi

    if [ -d ~/.oh-my-zsh ]; then
        echo "[install.sh]-- oh-my-zsh already installed"
    else
        echo "[install.sh]-- Installing oh-my-zsh"
        if sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" &>/dev/null; then
            echo "[install.sh]-- oh-my-zsh installed"
        else
            echo "[install.sh]-- oh-my-zsh installation failed"
            failedPackages+=("oh-my-zsh")
        fi
    fi

    echo "[install.sh]-- Installing python3"
    if apt install -y python3 &>/dev/null; then
        echo "[install.sh]-- python3 installed"
    else
        echo "[install.sh]-- python3 installation failed"
        failedPackages+=("python3")
    fi

    echo "[install.sh]-- Installing python3-pip"
    if apt install -y python3-pip &>/dev/null; then
        echo "[install.sh]-- python3-pip installed"
    else
        echo "[install.sh]-- python3-pip installation failed"
        failedPackages+=("python3-pip")
    fi
}

installFull() {
    echo "[install.sh]-- upgrading system"
    if apt upgrade -y &>/dev/null; then
        echo "[install.sh]-- system upgraded"
    else
        echo "[install.sh]-- system upgrade failed"
    fi

    echo "[install.sh]-- Installing UwUFetch"
    if installUwUFetch &>/dev/null; then
        echo "[install.sh]-- UwUFetch installed"
    else
        echo "[install.sh]-- UwUFetch installation failed"
        failedPackages+=("UwUFetch")
    fi

    echo "[install.sh]-- Installing Neofetch"
    if apt install -y neofetch &>/dev/null; then
        echo "[install.sh]-- Neofetch installed"
    else
        echo "[install.sh]-- Neofetch installation failed"
        failedPackages+=("Neofetch")
    fi

    echo "[install.sh]-- Installing htop"
    if apt install -y htop &>/dev/null; then
        echo "[install.sh]-- htop installed"
    else
        echo "[install.sh]-- htop installation failed"
        failedPackages+=("htop")
    fi

    echo "[install.sh]-- Installing nyancat"
    if apt install -y nyancat &>/dev/null; then
        echo "[install.sh]-- nyancat installed"
    else
        echo "[install.sh]-- nyancat installation failed"
        failedPackages+=("nyancat")
    fi
}

linkMin() {
    echo "[install.sh]-- Linking .gitconfig"
    rm -rf ~/.gitconfig
    if ln -s $HOME/.gitconfig ~/.gitconfig; then
        echo "[install.sh]-- .gitconfig linked"
    else
        echo "[install.sh]-- .gitconfig linking failed"
        failedLinks+=(".gitconfig")
    fi

    echo "[install.sh]-- Linking VScode settings"
    mkdir -p ~/.config/Code/User
    rm -rf ~/.config/Code/User/settings.json
    rm -rf ~/.config/Code/User/snippets
    if ln -s $HOME/VScode/settings.json ~/.config/Code/User/settings.json; then
        echo "[install.sh]-- VScode settings linked"
    else
        echo "[install.sh]-- VScode settings linking failed"
        failedLinks+=("VScode settings")
    fi
    if ln -s $HOME/VScode/snippets ~/.config/Code/User/snippets; then
        echo "[install.sh]-- VScode snippets linked"
    else
        echo "[install.sh]-- VScode snippets linking failed"
        failedLinks+=("VScode snippets")
    fi

    echo "[install.sh]-- Linking .tmux.conf"
    rm -rf ~/.tmux.conf
    if ln -s $HOME/.tmux.conf ~/.tmux.conf; then
        echo "[install.sh]-- .tmux.conf linked"
    else
        echo "[install.sh]-- .tmux.conf linking failed"
        failedLinks+=(".tmux.conf")
    fi

    echo "[install.sh]-- Linking .zshrc"
    rm -rf ~/.zshrc
    rm -rf ~/.fzf.zsh
    rm -rf ~/.oh-my-zsh/themes/cute.zsh-theme
    if ln -s $HOME/.zshrc ~/.zshrc; then
        echo "[install.sh]-- .zshrc linked"
    else
        echo "[install.sh]-- .zshrc linking failed"
        failedLinks+=(".zshrc")
    fi
    if ln -s $HOME/.fzf.zsh ~/.fzf.zsh; then
        echo "[install.sh]-- .fzf.zsh linked"
    else
        echo "[install.sh]-- .fzf.zsh linking failed"
        failedLinks+=(".fzf.zsh")
    fi
    if ln -s $HOME/cute.zsh-theme ~/.oh-my-zsh/themes/cute.zsh-theme; then
        echo "[install.sh]-- cute.zsh-theme linked"
    else
        echo "[install.sh]-- cute.zsh-theme linking failed"
        failedLinks+=("cute.zsh-theme")
    fi

    echo "[install.sh]-- Linking ssh config"
    mkdir -p ~/GitHub/Uni/
    mkdir -p ~/.ssh
    mv ~/.ssh/config ~/.ssh/config.bak
    if ln -s $HOME/Uni/sshConfig ~/.ssh/config; then
        echo "[install.sh]-- ssh config linked"
    else
        echo "[install.sh]-- ssh config linking failed"
        failedLinks+=("ssh config")
    fi
}

linkFull() {
    # full installation does not need linking currently
    echo ""
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
min) installType="minimal" ;;
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

if [ $installType == "minimal" ]; then
    printf "\n[install.sh]-- Installing minimal packages"
    printf "\n"
    installMin
    printf "\n[install.sh]-- Linking minimal files"
    printf "\n"
    linkMin
elif [ $installType == "full" ]; then
    printf "\n[install.sh]-- Installing full packages"
    printf "\n"
    installMin
    installFull
    printf "\n[install.sh]-- Linking full files"
    printf "\n"
    linkMin
    linkFull
fi

for package in "${failedPackages[@]}"; do
    echo "Failed to install: $package"
done
printf "\n"
for link in "${failedLinks[@]}"; do
    echo "Failed to link: $link"
done
