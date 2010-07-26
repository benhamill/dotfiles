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

" Text editor mode: Split verticle and set winwidth to 85. For use when maximized.
nmap <silent> ,tm :set textwidth=80<cr>


" Map ctrl-t to the command-t plugin command.
nmap <silent> <C-t> <Leader>t

" Map ctrl-n and ctrl-p to :cn and :cp respectively.
nmap <silent> <C-n> :cn<cr>
nmap <silent> <C-p> :cp<cr>

" Git Blame on Selection.
vmap <Leader>b :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

set guioptions-=T
set background=dark
colorscheme ir_black
set number
set lines=50 columns=100
set nowrap
set linebreak
set winwidth=85

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

set tags=./tags;

set grepprg=ack
