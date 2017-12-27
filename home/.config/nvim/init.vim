" Install plugins with https://github.com/junegunn/vim-plug
call plug#begin('~/.config/nvim/plugged')

Plug 'altercation/vim-colors-solarized'
Plug 'duff/vim-bufonly'
Plug 'elixir-lang/vim-elixir'
Plug 'jremmen/vim-ripgrep'
Plug 'godlygeek/tabular'
Plug 'hwasungmars/avro-vim'
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

call plug#end()


set number nowrap nohlsearch noswapfile

" Don't beep and don't flash. Bleh!
set visualbell

" My preferred default tab settings (makes tabs stand out)
set ts=4 sts=2 sw=2 expandtab

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
let g:deoplete#enable_smart_case = 1

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
autocmd BufNewFile,BufReadPost *.markdown set filetype=markdown
autocmd BufNewFile,BufReadPost *.markdown setlocal textwidth=80
let g:markdown_fenced_languages = ['ruby', 'sh', 'javascript', 'vim', 'python', 'go', 'elixir']

" NERDTree settings
nmap <silent> <leader>nt :NERDTreeToggle<cr>
let NERDTreeIgnore=['^Gemfile\.lock$', '\~$', '\.pyc$', '^_build$', '^__pycache__$']
let NERDTreeSortOrder=['*', '^[A-Z]', '^README*', '^Gemfile']

" CtrlP settings
let g:ctrlp_map = ''
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ }
nmap <silent> <leader>t :CtrlP<cr>

" Avro support
autocmd BufNewFile,BufRead *.avsc set filetype=json
autocmd BufNewFile,BufRead *.avdl setlocal tabstop=4 shiftwidth=4

" Python formatting
function! PythonFormat()
  if !executable("yapf")
    echoerr "Couldn't run `yapf`. Are you sure it's installed?"
    return
  endif

  if !executable("isort")
    echoerr "Couldn't run `isort`. Are you sure it's installed?"
    return
  endif

  " Save cursor position.
  let current_cursor = getpos('.')

  silent execute "0,$!yapf --style ./.yapfrc"

  " Restore cursor.
  call setpos('.', current_cursor)

  " Yapf failed, spit out error text into a new buffer.
  if v:shell_error == 1
    execute 'normal! gg"ayG'
    silent undo
    " execute 'normal!' . current_line . 'G'
    call setpos('.', current_cursor)
    silent new
    silent put a

    return
  endif

  silent execute "0,$!isort -"

  " Restore cursor.
  call setpos('.', current_cursor)

  " Isort failed, spit out error text into a new buffer.
  if v:shell_error != 0
    execute 'normal! gg"ayG'
    silent undo
    " execute 'normal!' . current_line . 'G'
    call setpos('.', current_cursor)
    silent new
    silent put a

    return
  endif
endfunction
" autocmd BufWritePre *.py call PythonFormat()

" Go support
autocmd BufNewFile,BufRead *.go setlocal noexpandtab sw=4
" My preferred default tab settings (makes tabs stand out)
" set ts=4 sts=2 sw=2 expandtab
