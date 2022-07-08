:set number
:set relativenumber
:set autoindent
:set tabstop=4
:set shiftwidth=4
:set smarttab
:set softtabstop=4
:set mouse=a

call plug#begin()

Plug 'http://github.com/tpope/vim-surround' " Surrounding ysw) (used to change surroundings)
Plug 'https://github.com/vim-airline/vim-airline' " Status bar (needs a nerd font)
Plug 'https://github.com/preservim/nerdtree' " NerdTree (File tree)
Plug 'https://github.com/ap/vim-css-color' " CSS Color Preview
Plug 'https://github.com/rafi/awesome-vim-colorschemes' " Retro Scheme
Plug 'https://github.com/ryanoasis/vim-devicons' " Developer Icons
Plug 'https://github.com/tc50cal/vim-terminal' " Vim Terminal
Plug 'https://github.com/terryma/vim-multiple-cursors' " CTRL + N for multiple cursors

" This one is special: It needs:
"	- nodejs (install with: https://github.com/nodesource/distributions/blob/master/README.md)
"	- npm
"	- yarn
Plug 'https://github.com/neoclide/coc.nvim'  " Auto Completion


call plug#end()

" --- Just Some Notes ---
" :PlugClean :PlugInstall :UpdateRemotePlugins
"
" :CocInstall coc-python

:colorscheme gruvbox


