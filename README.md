# My personal dotfiles

ignore everything here. Just my dotfiles
## Programs

1. Editor: VSCode
2. Terminal Multiplexer: tmux
3. Shell: zsh (with oh my zsh)

## Additional Files

1. git config
2. my old emacs config
3. a .dircolors file
4. my zsh theme

TODO: add installer
prob shell script
(new argparse project?? pog)

# Installation guide
## Install the tmux cpu mem program

```bash
git clone https://github.com/thewtex/tmux-mem-cpu-load.git tmuxLoad
cd tmuxLoad
cmake .
make
sudo make install
```

## Install UwUfetch

```bash
git clone https://github.com/TheDarkBug/uwufetch.git
cd uwufetch
make build # add "CFLAGS+=-D__IPHONE__" if you are building for iOS
sudo make install
```

