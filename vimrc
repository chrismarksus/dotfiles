runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

filetype plugin indent on
syntax on
colorscheme solarized
set background=dark
let g:solarized_termcolors=256

set nocompatible
set nobackup
set nowritebackup
set noswapfile
set splitbelow
set splitright
set incsearch
set confirm
set backspace=indent,eol,start
set autoread
set lazyredraw
set autoindent smartindent
set smarttab
set expandtab
set tabstop=4
set shiftwidth=4
set wrap
set textwidth=80
set clipboard=unnamed
set number
set ruler
set wildmode=list:longest
set wildmenu
set hlsearch
set showmatch
set copyindent
set ttyfast
set gdefault
set binary
set noeol
set tags=./tags

if has('folding')
    set nofoldenable
endif

set foldmethod=indent
set foldcolumn=4
set foldlevel=1

set suffixesadd+=.js
set suffixesadd+=.jsf
set suffixesadd+=.jsp
set suffixesadd+=.java
set suffixesadd+=.class
set suffixesadd+=.rb
set suffixesadd+=.soy
set suffixesadd+=.feature
set suffixesadd+=.php
set suffixesadd+=.groovy
set suffixesadd+=.html
set suffixesadd+=.css
set suffixesadd+=.scss
set suffixesadd+=.sass

autocmd Filetype ruby setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd Filetype gitcommit,markdown,text,txt setlocal spell

if filereadable(glob("~/.vimrc_local")) 
    source ~/.vimrc_local
endif
