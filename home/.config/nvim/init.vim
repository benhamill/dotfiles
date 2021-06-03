" Install plugins with https://github.com/junegunn/vim-plug
call plug#begin('~/.config/nvim/plugged')

Plug 'altercation/vim-colors-solarized'
Plug 'duff/vim-bufonly'
Plug 'elixir-lang/vim-elixir'
Plug 'jremmen/vim-ripgrep'
Plug 'godlygeek/tabular'
Plug 'honza/vim-snippets'
Plug 'IN3D/vim-raml'
Plug 'kien/ctrlp.vim'
Plug 'mrk21/yaml-vim' " For highlighting the | and > of strings and - for lists.
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'SirVer/ultisnips'
Plug 'Shougo/deoplete.nvim'
Plug 'Shougo/neco-vim'
Plug 'slashmili/alchemist.vim'
Plug 'tomtom/tcomment_vim'
Plug 'Townk/vim-autoclose'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-surround'
Plug 'fatih/vim-go', { 'tag': '*', 'for': 'go' }
Plug 'jparise/vim-graphql'

call plug#end()

" To avoid remote code execution problems.
set nomodeline

set number nowrap nohlsearch noswapfile

" Don't beep and don't flash. Bleh!
set visualbell

" My preferred default tab settings (makes tabs stand out)
set tabstop=4 softtabstop=2 shiftwidth=2 expandtab

" Set windows up
set winwidth=85 colorcolumn=81 list listchars=tab:▸\ ,trail:•

" Set up my statusline
set statusline=%f%(\ %M%)%(\ %R%)%(\ %W%)%(\ %y%)%=%-14.(%l,%c%V%)\ %P
set wildmode=longest:full

" Colors
set background=dark
colorscheme solarized

" VERY MAGIC ALL THE TIME!
nnoremap /  /\v
cnoremap s/ s/\v

" When editing a line, put a $, instead of redisplaying.
set cpoptions+=$

" Toggle paste mode
set pastetoggle=<C-t>


let mapleader = ","

" Edit this file
nmap <silent> <leader>v :vsp $MYVIMRC<cr>

" Map tab and shift-tab to switch buffers.
nmap <silent> <tab> :bn<cr>
nmap <silent> <S-tab> :bp<cr>

" Map ctrl-n and ctrl-p to :cn and :cp respectively.
nmap <silent> <C-n> :cn<cr>
nmap <silent> <C-p> :cp<cr>


" Easier window nav
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" In terminal mode, remap double-escape to go back to normal mode.
tnoremap <Esc><Esc> <C-\><C-n>

" Next buffer and close old one.
command! BD :bp<bar>:bd#

" Open terminal in vsplit
command! Vterminal :vs<bar>:terminal

" Open terminal in split
command! Sterminal :sp<bar>:terminal


" Deoplete settings
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option({
  \ 'smart_case': v:true,
\})

" Elixir.nvim settings
let g:elixir_comp_minlen = 2

" UltiSnips settings
let g:UltiSnipsEditSplit = 'context'
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<shift-tab>"

" Neopairs settings
let g:neopairs#enable = 1

" Markdown support
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd BufNewFile,BufReadPost *.md setlocal textwidth=80
autocmd BufNewFile,BufReadPost *.md setlocal spell spelllang=en_us
autocmd BufNewFile,BufReadPost *.markdown set filetype=markdown
autocmd BufNewFile,BufReadPost *.markdown setlocal textwidth=80
autocmd BufNewFile,BufReadPost *.markdown setlocal spell spelllang=en_us
let g:markdown_fenced_languages = ['ruby', 'sh', 'javascript', 'vim', 'python', 'go', 'elixir']

" Dot/Graphviz support
autocmd BufWritePost *.dot silent !command dot -Tsvg -o<afile>.svg <afile>

" NERDTree settings
nmap <silent> <leader>nt :NERDTreeToggle<cr>
let NERDTreeIgnore=['^Gemfile\.lock$', '\~$', '\.pyc$', '^_build$', '^__pycache__$']
let NERDTreeSortOrder=['*', '^[A-Z]', '^README*', '^Gemfile']

" CtrlP settings
let g:ctrlp_map = ''
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|pkg)$',
  \ }
nmap <silent> <leader>t :CtrlP<cr>

" Avro support
autocmd BufNewFile,BufRead *.avsc set filetype=json
autocmd BufNewFile,BufRead *.avdl setlocal tabstop=4 shiftwidth=4

" Go support
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=2 listchars=tab:\ \ ,trail:•

" Tabs in JS
autocmd BufNewFile,BufRead *.js setlocal noexpandtab shiftwidth=4 tabstop=4 listchars=tab:\ \ ,trail:•
autocmd BufNewFile,BufRead *.jsx setlocal noexpandtab shiftwidth=4 tabstop=4 listchars=tab:\ \ ,trail:•

" My preferred default tab settings (makes tabs stand out)
" set ts=4 sts=2 sw=2 expandtab

" Enable clipbiard on WSL
set clipboard+=unnamedplus
let g:clipboard = {
  \   'name': 'win32yank-wsl',
  \   'copy': {
  \      '+': 'win32yank.exe -i --crlf',
  \      '*': 'win32yank.exe -i --crlf',
  \    },
  \   'paste': {
  \      '+': 'win32yank.exe -o --lf',
  \      '*': 'win32yank.exe -o --lf',
  \   },
  \   'cache_enabled': 0,
  \ }
