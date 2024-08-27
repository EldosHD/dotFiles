#!/bin/bash
git clone https://github.com/catppuccin/bat.git
cd bat
cd themes
mkdir -p "$(bat --config-dir)/themes"
cp *.tmTheme "$(bat --config-dir)/themes"
bat cache --build
cd ..
cd ..
rm -rf bat
