#!/bin/bash
cd /tmp
git clone https://github.com/catppuccin/ulauncher.git
cd ulauncher
python3 install.py -f mocha -a pink
cd ..
rm -rf ulauncher