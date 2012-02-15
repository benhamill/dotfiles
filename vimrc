runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

runtime macros/matchit.vim

set nocompatible

let mapleader=","

filetype off

syntax on
filetype plugin indent on

" My preferred default tab settings (makes tabs stand out)
set ts=4 sts=2 sw=2 expandtab

" Only do this part when compiled with support for autocommands
if has("autocmd")
  " Syntax of these languages is fussy over tabs Vs spaces
  autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
  autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
  autocmd Filetype text setlocal tw=80 formatoptions+=a spell

  " Syntax highlighting for pig files
  autocmd BufNewFile,BufRead *.pig set filetype=pig syntax=pig

  autocmd BufNewFile,BufRead *.tsv set filetype=tsv
  autocmd FileType tsv set noexpandtab
  autocmd FileType tsv set list

  " Automatically source my vimrc when I save it
  autocmd BufWritePost .vimrc source $MYVIMRC
endif

" Lots of colors
set t_Co=256

" For showing hidden characters
set list listchars=tab:▸\ ,trail:•

" Trim trailing whitespace on command
command! TW :call <SID>StripTrailingWhitespaces()<CR>

function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

" Next buffer and close old one.
command! BD :bp<bar>:bd#

set hidden

set lazyredraw

set showmode

set wildmenu

set autoread

" Edit this file
nmap <silent> <leader>v :vsp $MYVIMRC<cr>

" Easier window nav
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" Quick access for NERDTree
nmap <silent> <leader>nt :NERDTreeToggle<cr>

" Sort files and directories mixed up.
let NERDTreeSortOrder=['*', '^[A-Z]', '^README.*', '^Gemfile']
let NERDTreeDirArrows=1
let NERDTreeIgnore=['^tags$', '^Gemfile\.lock$', '\~$']

" Map ctrl-n and ctrl-p to :cn and :cp respectively.
nmap <silent> <C-n> :cn<cr>
nmap <silent> <C-p> :cp<cr>

" Map tab and shift-tab to switch buffers.
nmap <silent> <tab> :bn<cr>
nmap <silent> <S-tab> :bp<cr>

" Git Blame on Selection.
vmap <Leader>b :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

" FuzzyFinder Shortcuts
nmap <Leader>t :FufTaggedFile<CR>

" Refresh CTags
nmap <Leader>c :!ctags --extra=+fq -R .<CR><CR>

set background=dark
colorscheme solarized
set number
set nowrap
set linebreak
set winwidth=85
set encoding=utf-8
set completeopt=menu,preview,longest

set laststatus=2
set statusline=%f%(\ %M%)%(\ %R%)%(\ %W%)%(\ %y%)%=%-14.(%l,%c%V%)\ %P

set ai
set cpoptions+=$

set tags=./tags;

set pastetoggle=<F2>

set noswapfile
set nobackup

let g:CommandTMaxFiles=30000

" Don't beep and don't flash. Bleh!
set noeb vb t_vb=
