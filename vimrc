runtime bundle/vim-pathogen/autoload/pathogen.vim
"call pathogen#runtime_append_all_bundles()
call pathogen#infect()
call pathogen#helptags()

set t_Co=256
let g:solarized_termcolors=256

filetype plugin indent on
colorscheme phix
set background=dark

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
  let g:airline_theme='powerlineish'
endif

" CtrlP custom ignore
let g:ctrlp_custom_ignore = 'node_modules\|bower_components\|DS_Store\|git'

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

syntax on

set laststatus=2

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
set suffixesadd+=.less
set suffixesadd+=.scss
set suffixesadd+=.sass

autocmd Filetype less,css,scss,sass,stylus setlocal shiftwidth=4 tabstop=4 softtabstop=4 expandtab
autocmd Filetype ruby setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd Filetype gitcommit,markdown,text,txt setlocal spell
autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
autocmd BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn} set filetype=markdown

if filereadable(glob("~/.vimrc_local"))
    source ~/.vimrc_local
endif
