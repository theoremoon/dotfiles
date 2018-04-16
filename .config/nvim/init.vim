" plugin manager 
call plug#begin('~/.vim/plugged')
  Plug 'junegunn/vim-easy-align'
  Plug 'tpope/vim-surround' "select and S[surrounder], cs[from][to], ds[surrounder]
  Plug 'tpope/vim-commentary'  "gcc -> comment in/out
  Plug 'mbbill/undotree'
  Plug 'jiangmiao/auto-pairs'
  Plug 'simnalamburt/vim-mundo'
  Plug 'airblade/vim-gitgutter'
  Plug 'w0rp/ale'
  Plug 'haya14busa/incsearch.vim'
  Plug 'haya14busa/incsearch-fuzzy.vim'
  Plug 'mattn/emmet-vim', { 'for': ['html', 'css', 'js'] } "C-y , on insert mode
  Plug 'sheerun/vim-polyglot'
  Plug 'itchyny/lightline.vim'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'LeafCage/yankround.vim'
  Plug 'autozimu/LanguageClient-neovim', {
        \ 'branch': 'next',
        \ 'do': 'bash install.sh',
        \ }
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" colorscheme
  Plug 'yamasy1549/gochiusa.vim'
  Plug 'junegunn/seoul256.vim'
  Plug 'romainl/Apprentice'
call plug#end()

set number
set autoindent
set smartindent
" set lazyredraw 
set laststatus=2
set showcmd
set visualbell
set backspace=indent,eol,start
set timeoutlen=500  "for mapped key timeout
set whichwrap=b,s  "for <BS>, <Space> move in normal mode
set shortmess=aIT
set hlsearch
set incsearch
set hidden  "use hidden buffer
set ignorecase smartcase
set wildmenu  "use tab completion on command-line mode
set wildmode=full
set tabstop=2
set shiftwidth=2
set expandtab smarttab
set scrolloff=5
set encoding=utf-8
set list  "for display trailing whitespace
set listchars=tab:\|\  "tab showed as |
set virtualedit=block
set nojoinspaces
set diffopt=filler,vertical
set autoread
set clipboard=""
set grepformat=%f:%l:%c:%m,%f:%l:%m  "parse format for external grep
set completeopt=menuone,preview
set nocursorline
set nrformats=hex
set formatoptions+=1j
set breakindent
if has('termguicolors')
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
set backupdir=~/.vim/backupdir
set directory=~/.vim/swapdir
set undodir=~/.vim/undodir
set viminfo+=n~/.vim/viminfo
set complete=.,w,b,u,k,i,d,t  "current buffer, other buffers, buffer lists, dictionary, current file and includes, same, tagfiles
set textwidth=0
set isfname-==  "= is not filename
set nofixeol
set signcolumn=yes

if !isdirectory(expand("~/.vim/backupdir"))
  call mkdir(expand("~/.vim/backupdir"))
endif
if !isdirectory(expand("~/.vim/swapdir"))
  call mkdir(expand("~/.vim/swapdir"))
endif
if !isdirectory(expand("~/.vim/undodir"))
  call mkdir(expand("~/.vim/undodir"))
endif

let mapleader="\<Space>"
let maplocalleader="\<Space>"

""" mappings

" open new line 
nnoremap <Leader>o o<Esc>
nnoremap <Leader>O O<Esc>

" Save
nnoremap <Leader>w :w<CR>

" Quit
nnoremap <Leader>q :q<CR>
nnoremap <Leader>Q :qa!<CR>

" source $MYVIMRC
nnoremap <Leader>e :source $MYVIMRC<CR>

inoremap jk <Esc>

" Move in insert mode 
inoremap <C-h> <C-o>h
inoremap <C-l> <C-o>a
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
inoremap <C-a> <C-o>0
inoremap <C-e> <C-o>$

" QuickFix
nnoremap ]q :cnext<CR>zz
nnoremap [q :cprev<CR>zz
nnoremap ]l :lnext<CR>zz
nnoremap [l :lprev<CR>zz

" Buffers
nnoremap ]b :bnext<CR>
nnoremap [b :bprev<CR>

" Tabs
nnoremap ]t :tabn<CR>
nnoremap [t :tabp<CR>

" Command Line mode
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" copy and paste
vnoremap <Leader>y "+y
vnoremap <Leader>p "+p
nnoremap <Leader>p "+p

" -- Plugins ---
xmap ga <Plug>(EasyAlign)  "usage: ga=, ga2|

nnoremap U :UndotreeToggle<CR>

nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap gp <Plug>(yankround-gp)
nmap gP <Plug>(yankround-gP)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)

map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map z/ <Plug>(incsearch-fuzzy-/)
map z? <Plug>(incsearch-fuzzy-?)
map zg/ <Plug>(incsearch-fuzzy-stay)

nnoremap <Leader>j :Ag<CR>
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>t :Tags<CR>
nnoremap <C-p> :Files<CR>
let g:fzf_tags_command='ctags -R'
autocmd Filetype d let g:fzf_tags_command='dscanner --ctags > tags'

let g:ale_set_loclist=0
let g:ale_set_quickfix=1

let g:deoplete#enable_at_startup=1

let g:LanguageClient_severCommands ={
  \ 'd': ['serve-d'],
  \ }
nnoremap <silent>gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent>rn :call LanguageClient#textDocument_rename()<CR>


colorscheme seoul256
syntax on
