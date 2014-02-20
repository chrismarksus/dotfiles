runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()


filetype plugin indent on
syntax on
set nocompatible
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
set suffixesadd+=.property
set suffixesadd+=.php
set suffixesadd+=.groovy

autocmd Filetype ruby setlocal shiftwidth=2 tabstop=2 softtabstop=2

if filereadable(glob("~/.vimrc_local")) 
    source ~/.vimrc.local
endif
