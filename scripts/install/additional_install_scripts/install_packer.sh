if [ -d ~/.local/share/nvim/site/pack/packer/start/packer.nvim ]; then
  echo "packer.nvim already installed"
  exit 0
else
  echo "installing packer.nvim"
  git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
fi
