call plug#begin('~/.vim/plugged')
Plug 'SirVer/ultisnips'
Plug 'Townk/vim-autoclose'
Plug 'bps/vim-textobj-python'
Plug 'cakebaker/scss-syntax.vim'
Plug 'duff/vim-bufonly'
Plug 'elixir-lang/vim-elixir'
Plug 'epmatsw/ag.vim'
Plug 'fatih/vim-go'
Plug 'godlygeek/tabular'
Plug 'honza/vim-snippets'
Plug 'kana/vim-textobj-user'
Plug 'kien/ctrlp.vim'
Plug 'lepture/vim-jinja'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'rking/vim-detailed'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'slim-template/vim-slim'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/fish.vim'
call plug#end()

runtime macros/matchit.vim
set runtimepath+=$GOROOT/misc/vim

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
  autocmd BufNewFile,BufRead *.jbuilder set filetype=ruby
  autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
  autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
  autocmd FileType jinja setlocal ts=4 sts=4 sw=4 expandtab
  autocmd FileType php setlocal ts=4 sts=4 sw=4 expandtab
  autocmd Filetype text setlocal tw=80 spell
  " autocmd Filetype text setlocal tw=80 formatoptions+=a spell
  autocmd Filetype choicescript setlocal tw=80 spell formatoptions-=a ts=4 sts=4 sw=4 expandtab
  autocmd Filetype help setlocal nospell
  autocmd BufNewFile,BufRead *.md set filetype=markdown syntax=markdown
  autocmd Filetype markdown setlocal spell tw=80
  autocmd Filetype gitcommit setlocal spell tw=72
  autocmd Filetype go setlocal ts=4 sts=4 sw=4 noexpandtab
  autocmd FileType go map <leader>r <Plug>(go-run)
  autocmd FileType go map <leader>t <Plug>(go-test)
  autocmd FileType go map <leader>b <Plug>(go-build)
  autocmd FileType go nmap <Leader>e <Plug>(go-rename)
  autocmd FileType go nmap <Leader>gb <Plug>(go-doc-browser)
  autocmd FileType go nmap <Leader>l :GoLint<cr>
  autocmd Filetype snippets setlocal ts=4 sts=4 sw=4 noexpandtab
  autocmd BufNewFile,BufRead *.raml set filetype=yaml syntax=yaml

  " Syntax highlighting for pig files
  autocmd BufNewFile,BufRead *.pig set filetype=pig syntax=pig

  autocmd BufNewFile,BufRead *.tsv set filetype=tsv
  autocmd FileType tsv setlocal noexpandtab

  autocmd BufNewFile,BufRead *.fish set filetype=fish syntax=fish

  autocmd BufNewFile,BufRead *.avsc set filetype=json syntax=json

  " Automatically source my vimrc when I save it
  autocmd BufWritePost .vimrc source $MYVIMRC
endif

" Just... know where 80 characters is.
set colorcolumn=81

" For showing hidden characters
set list listchars=tab:▸\ ,trail:•

" Trim trailing whitespace on command
command! TW :call <SID>StripTrailingWhitespaces()

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
let NERDTreeSortOrder=['*', '^[A-Z]', '^README*', '^Gemfile']
let NERDTreeDirArrows=1
let NERDTreeIgnore=['^tags$', '^Gemfile\.lock$', '\~$', '\.pyc$']

" Map ctrl-n and ctrl-p to :cn and :cp respectively.
nmap <silent> <C-n> :cn<cr>
nmap <silent> <C-p> :cp<cr>

" Map tab and shift-tab to switch buffers.
nmap <silent> <tab> :bn<cr>
nmap <silent> <S-tab> :bp<cr>

" Refresh CTags
nmap <leader>c :!ctags --exclude=doc --langmap=Ruby:+.haml.slim.erb --langmap=php:+.inc --extra=+fq -R --langdef=scss --langmap=scss:.scss.sass.css .<CR><CR>

" Convert => to : in ruby hashes
nnoremap <Leader>: :%s/:\([^ ]*\)\(\s*\)=>/\1:/gc<CR>

" CtrlP changes
let g:ctrlp_map = ''
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ }
nmap <silent> <leader>t :CtrlP<cr>

" VERY MAGIC ALL THE TIME!
nnoremap /  /\v
cnoremap s/ s/\v

" RCodeTools commands
" Run one line
map <silent> <leader>r !xmpfilter -a<cr>
nmap <silent> <leader>r V<leader>r

" Run whole buffer
nmap <silent> <leader>R mzggVG!xmpfilter -a<cr>'z'


set background=dark
colorscheme detailed
set number
set nowrap
set linebreak
set winwidth=85
set encoding=utf-8
set completeopt=menu,preview,longest
set wildmode=longest:full

set laststatus=2
set statusline=%f%(\ %M%)%(\ %R%)%(\ %W%)%(\ %y%)%=%-14.(%l,%c%V%)\ %P

set ai
set cpoptions+=$

set tags=./tags;

set pastetoggle=<C-t>

set noswapfile
set nobackup

" Delete even stuff that I didn't type just now
set backspace=indent,eol,start

let g:CommandTMaxFiles=30000
let g:markdown_fenced_languages = ['ruby', 'sh', 'javascript', 'vim', 'python', 'go']

let g:UltiSnipsEditSplit = 'context'
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<shift-tab>"

" Don't beep and don't flash. Bleh!
set noeb vb t_vb=
