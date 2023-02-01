#!/bin/bash

# require sudo
if [ $(id -u) != "0" ]; then
    echo "This script has to be run as sudo"
    exit
fi

failedPackages=()
failedLinks=()
startWokringDir=$(pwd)

# TODO: add only link and only install options
usage() {
    echo "usage: install.sh [OPTION] SUBCOMMAND"
    echo "Possible Options:"
    echo "   -l      | list all programs and files that will be installed with the selected mode"
    echo "   -h      | show this help message and exit"
    echo "Possible subcommands:"
    echo "    full   | full installation (also runs apt upgrade)"
    echo "    min    | minimal installtion"
    echo "    links  | only create symlinks"
    echo "    pack    | only install packages"
    exit
}

installFzF() {
    rm -rf /home/$SUDO_USER/.fzf
    echo "[install.sh]-- cloning repo"
    git clone --depth 1 https://github.com/junegunn/fzf.git /home/$SUDO_USER/.fzf
    echo "[install.sh]-- finished cloning repo"
    /home/$SUDO_USER/.fzf/install --key-bindings --completion --no-update-rc
}

installTmuxCpuMemProgram() {
    echo "[install.sh]-- cloning repo"
    git clone https://github.com/thewtex/tmux-mem-cpu-load.git tmuxLoad
    cd tmuxLoad
    echo "[install.sh]-- making install"
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

    echo "[install.sh]-- Installing cmake"
    if apt install -y cmake &>/dev/null; then
        echo "[install.sh]-- cmake installed"
        # program needs cmake to install properly
        echo "[install.sh]-- Installing tmux cpu and memory program"
        if installTmuxCpuMemProgram &>/dev/null; then
            echo "[install.sh]-- tmux cpu and memory program installed"
        else
            echo "[install.sh]-- tmux cpu and memory program installation failed"
            failedPackages+=("tmux cpu and memory program")
        fi
    else
        echo "[install.sh]-- cmake installation failed"
        failedPackages+=("cmake")
    fi

    echo "[install.sh]-- Installing tmux"
    if apt install -y tmux &>/dev/null; then
        echo "[install.sh]-- tmux installed"
    else
        echo "[install.sh]-- tmux installation failed"
        failedPackages+=("tmux")
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

    # required for zsh theme
    echo "[install.sh]-- Installing fonts-powerline"
    if apt install -y fonts-powerline &>/dev/null; then
        echo "[install.sh]-- fonts-powerline installed"
    else
        echo "[install.sh]-- fonts-powerline installation failed"
        failedPackages+=("fonts-powerline")
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

    echo "[install.sh]-- Installing fzf"
    if installFzF &>/dev/null; then
        echo "[install.sh]-- fzf installed"
    else
        echo "[install.sh]-- fzf installation failed"
        failedPackages+=("fzf")
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
    cd $startWokringDir
    echo "[install.sh]-- Linking .gitconfig"
    rm -f /home/$SUDO_USER/.gitconfig &>/dev/null
    if ln -s $(pwd)/.gitconfig /home/$SUDO_USER/.gitconfig; then
        echo "[install.sh]-- .gitconfig linked"
    else
        echo "[install.sh]-- .gitconfig linking failed"
        failedLinks+=(".gitconfig")
    fi

    echo "[install.sh]-- Linking VScode settings"
    mkdir -p /home/$SUDO_USER/.config/Code/User &>/dev/null
    rm -f /home/$SUDO_USER/.config/Code/User/settings.json &>/dev/null
    rm -f /home/$SUDO_USER/.config/Code/User/snippets &>/dev/null
    if ln -s $(pwd)/VScode/settings.json /home/$SUDO_USER/.config/Code/User/settings.json; then
        echo "[install.sh]-- VScode settings linked"
    else
        echo "[install.sh]-- VScode settings linking failed"
        failedLinks+=("VScode settings")
    fi
    if ln -s $(pwd)/VScode/snippets /home/$SUDO_USER/.config/Code/User/snippets; then
        echo "[install.sh]-- VScode snippets linked"
    else
        echo "[install.sh]-- VScode snippets linking failed"
        failedLinks+=("VScode snippets")
    fi

    echo "[install.sh]-- Linking .tmux.conf"
    rm -f /home/$SUDO_USER/.tmux.conf
    if ln -s $(pwd)/.tmux.conf /home/$SUDO_USER/.tmux.conf; then
        echo "[install.sh]-- .tmux.conf linked"
    else
        echo "[install.sh]-- .tmux.conf linking failed"
        failedLinks+=(".tmux.conf")
    fi

    echo "[install.sh]-- Linking .zshrc"
    rm -f /home/$SUDO_USER/.zshrc &>/dev/null
    rm -f /home/$SUDO_USER/.fzf.zsh &>/dev/null
    rm -f /home/$SUDO_USER/.oh-my-zsh/custom/themes/cute.zsh-theme &>/dev/null
    if ln -s $(pwd)/.zshrc /home/$SUDO_USER/.zshrc; then
        echo "[install.sh]-- .zshrc linked"
    else
        echo "[install.sh]-- .zshrc linking failed"
        failedLinks+=(".zshrc")
    fi
    if ln -s $(pwd)/.fzf.zsh /home/$SUDO_USER/.fzf.zsh; then
        echo "[install.sh]-- .fzf.zsh linked"
    else
        echo "[install.sh]-- .fzf.zsh linking failed"
        failedLinks+=(".fzf.zsh")
    fi
    if ln -s $(pwd)/cute.zsh-theme /home/$SUDO_USER/.oh-my-zsh/custom/themes/cute.zsh-theme; then
        echo "[install.sh]-- cute.zsh-theme linked"
    else
        echo "[install.sh]-- cute.zsh-theme linking failed"
        failedLinks+=("cute.zsh-theme")
    fi

    echo "[install.sh]-- Linking ssh config"
    mkdir -p /home/$SUDO_USER/GitHub/Uni/ &>/dev/null
    mkdir -p /home/$SUDO_USER/.ssh/ &>/dev/null
    mv /home/$SUDO_USER/.ssh/config /home/$SUDO_USER/.ssh/config.bak &>/dev/null
    if ln -s $(pwd)/Uni/sshConfig /home/$SUDO_USER/.ssh/config; then
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
min | minimal) installType="minimal" ;;
full) installType="full" ;;
links | links) installType="links" ;;
pack | packages) installType="packages" ;;
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
elif [ $installType == "links" ]; then
    printf "\n[install.sh]-- Linking files"
    printf "\n"
    linkMin
    linkFull
elif [ $installType == "packages" ]; then
    printf "\n[install.sh]-- Installing packages"
    printf "\n"
    installMin
    installFull
fi

printf "\n\n"
for package in "${failedPackages[@]}"; do
    echo "Failed to install: $package"
done
printf "\n"
for link in "${failedLinks[@]}"; do
    echo "Failed to link: $link"
done