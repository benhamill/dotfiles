set nocompatible

filetype off

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

syntax on
filetype plugin indent on

augroup filetypedetect
  au BufNewFile,BufRead *.pig set filetype=pig syntax=pig
augroup END

set t_Co=256

runtime macros/matchit.vim

" Highlight whitespace
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=darkgray guibg=#333333
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Highlight tabs
" autocmd ColorScheme * highlight Tabs ctermbg=darkred guibg=#440000
" autocmd BufWinEnter * match Tabs /\t\+/
" autocmd InsertEnter * match Tabs /\t\+/
" autocmd InsertLeave * match Tabs /\t\+/
" autocmd BufWinLeave * call clearmatches()

" And trim it on command
command! TW :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s

" Next buffer and close old one.
command! BD :bp<bar>:bd#

set hidden

set lazyredraw

set showmode

set wildmenu

set autoread

" Macros to edit this file and then to source it
nmap <silent> ,ev :e $MYVIMRC<cr>
nmap <silent> ,sv :so $MYVIMRC<cr>

" Text editor mode
autocmd BufWinEnter *.txt set textwidth=80

" Quick access for NERDTree
nmap <silent> ,nt :NERDTreeToggle<cr>

" Sort files and directories mixed up.
let NERDTreeSortOrder=['*', '^[A-Z]', '^README.*', '^Gemfile']
let NERDTreeDirArrows=1
let NERDTreeIgnore=['^tags$', '^Gemfile\.lock$', '\~$']

" Map ctrl-t to the command-t plugin command.
nmap <silent> <C-t> <Leader>t

" Map ctrl-n and ctrl-p to :cn and :cp respectively.
nmap <silent> <C-n> :cn<cr>
nmap <silent> <C-p> :cp<cr>

" Map tab and shift-tab to switch buffers.
nmap <silent> <tab> :bn<cr>
nmap <silent> <S-tab> :bp<cr>

" Git Blame on Selection.
vmap <Leader>b :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

set background=dark
colorscheme solarized
set number
set nowrap
set linebreak
set winwidth=85
set encoding=utf-8

set laststatus=2
set statusline=%f%(\ %M%)%(\ %R%)%(\ %W%)%(\ %y%)%=%-14.(%l,%c%V%)\ %P

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

let g:CommandTMaxFiles=30000

" Don't beep and don't flash. Bleh!
set noeb vb t_vb=
