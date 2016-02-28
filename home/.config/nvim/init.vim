" Install plugins with https://github.com/junegunn/vim-plug
call plug#begin('~/.config/nvim/plugged')

Plug 'altercation/vim-colors-solarized'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Shougo/deoplete.nvim'

call plug#end()


set number nowrap nohlsearch noswapfile

" Set windows up
set winwidth=85 colorcolumn=81 list listchars=tab:▸\ ,trail:•

" Set up my statusline
set statusline=%f%(\ %M%)%(\ %R%)%(\ %W%)%(\ %y%)%=%-14.(%l,%c%V%)\ %P

" Colors
set background=dark
colorscheme solarized


let mapleader=","

" Edit this file
nmap <silent> <leader>v :vsp $MYVIMRC<cr>

" Quick access for NERDTree
nmap <silent> <leader>nt :NERDTreeToggle<cr>


" Easier window nav
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l


" Deoplete settings
let g:deoplete#enable_at_startup=1
let g:deoplete#enable_smart_case=1
