# My Dotfiles

This repository contains my dotfiles for my linux setup. I use [toml-bombadil](https://github.com/oknozor/toml-bombadil) to manage my dotfiles.

## Installation

First you need to clone this repository:
```bash
git clone https://github.com/EldosHD/dotFiles.git ~/my_dotfiles
```

### Prequesits

You need curl, a nerd font, rust and toml-bombadil installed.

The curl (for later installing rust) and the nerd font you can get from your package manager:

**Arch**: 
```bash
sudo pacman -S --noconfirm ttf-firacode-nerd curl
```

---

Rust you can get from [rustup](https://rustup.rs/):

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

And toml-bombadil you can get from cargo:

```bash
cargo install toml-bombadil
```

### Installing the dotfiles and dependencies

First I'd like to install a couple programs I find useful:

**Arch**: I use `yay` for installing from the AUR. You'll need to install `yay`, if your distro  doesn't ship with it.
```bash
yay -S --noconfirm visual-studio-code-bin google-chrome thunderbird discord
```

---

Then install all additional rust binaries:
```bash
cargo install exa du-dust bat starship zellij
```

---

Lastly setup toml-bombadil and link the dotfiles:
```bash
bombadil install ~/my_dotfiles
bombadil link 
```

### Post Install

You may need to execute the following commands to get everything working:

---

The **NVIM Plugin Manager**:
```bash
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```
Run `:so` in `nvim/lua/EldosHD/packer.lua` afterwords.

---

**UwUfetch**:
```bash
git clone https://github.com/TheDarkBug/uwufetch.git
cd uwufetch
make build # add "CFLAGS+=-D__IPHONE__" if you are building for iOS
sudo make install
```
