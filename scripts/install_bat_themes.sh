#!/bin/bash
git clone https://github.com/catppuccin/bat.git
cd bat
mkdir -p "$(bat --config-dir)/themes"
cp *.tmTheme "$(bat --config-dir)/themes"
bat cache --build
cd ..
rm -rf bat
