pkgname='eldos-default-packages'
pkgver=1.0
pkgrel=1
pkgdesc="simply installs all packages and links all dotfiles that I need on a fresh install of arch linux"
arch=('x86_64')
url="https://github.com/EldosHD/dotFiles"
license=('Boost')
depends=(
    # Shell stuff
    'tmux'
    'zsh'
    # Editors
    'neovim'
    'visual-studio-code-bin'
    # Tools
    'curl'
    'wget'
    'python'
    'python-pip'
    'fzf'
    'htop'
    # Misc
    'neofetch'
    'nyancat'
    
)

package() {
    # Install zsh modules for autocompletion
    git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting

    # Install oh my zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    # Install packer for Neovim
    git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

    # Install the tmux cpu mem program
    git clone https://github.com/thewtex/tmux-mem-cpu-load.git tmuxLoad
    cd tmuxLoad
    cmake .
    make
    sudo make install

    # Install UwUfetch
    git clone https://github.com/TheDarkBug/uwufetch.git
    cd uwufetch
    make build # add "CFLAGS+=-D__IPHONE__" if you are building for iOS
    sudo make install
}