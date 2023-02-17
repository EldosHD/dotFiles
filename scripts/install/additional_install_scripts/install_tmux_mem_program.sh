#!/usr/bin/bash
git clone https://github.com/thewtex/tmux-mem-cpu-load.git tmuxLoad
cd tmuxLoad
cmake .
make
sudo make install
cd ..
sudo rm -rf tmuxLoad
