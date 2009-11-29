set nocompatible

filetype on
filetype plugin on
filetype indent on

syntax on

set hidden

set lazyredraw

set showmode

set wildmenu

" Macros to edit this file and then to source it.
nmap <silent> ,ev :e $MYVIMRC<cr>
nmap <silent> ,sv :so $MYVIMRC<cr>

" Add a line below this one and set to insert on this line.
nmap <silent> ,il o<esc>ki

" Jump back to the first non-blank character in this line.
nmap <silent> ,b 0w

set guioptions-=T
set background=dark
colorscheme ir_black
set number
set lines=50 columns=100
set nowrap
set linebreak

function! Tabstyle_spaces()
  " Use 2 spaces
  set softtabstop=2
  set shiftwidth=2
  set tabstop=2
  set expandtab
endfunction

call Tabstyle_spaces()

set si
set ai
set cpoptions+=$

