set nocompatible
set laststatus=2
set cursorline

set softtabstop=0
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab

set autoindent
set smartindent

set textwidth=0                              " dont break line (different with wrap line{{{{{{
let &showbreak = '+++ '                      " show wrap string
set display=truncate,uhex                    " show @@@ as (displayed) last line's first character, show unprintable character as <xx> formatted
set linebreak                                " wrap on specific characters (breakat)
set nobreakindent                            " dont insert visually space when wrap line
set whichwrap=b,s,h,l,<,>                    " BS Space h l left right can move over line
set wrap                                     " wrap long line}}}}}}

set directory=~/.vim/swapdir
set swapfile
set undodir=~/.vim/undodir
set undofile
set viminfo+=n~/.vim/viminfo
set writebackup
if !isdirectory(expand("~/.vim/backupdir"))
  call mkdir(expand("~/.vim/backupdir"))
endif
if !isdirectory(expand("~/.vim/swapdir"))
  call mkdir(expand("~/.vim/swapdir"))
endif
if !isdirectory(expand("~/.vim/undodir"))
  call mkdir(expand("~/.vim/undodir"))
endif
"""{{{ Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END
"}}}
"{{{vim-plug
if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif
if has('nvim')
  if !filereadable(expand("~/.local/share/nvim/site/autoload/plug.vim"))
    :! curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  endif
else
  if !filereadable(expand("~/.vim/autoload/plug.vim"))
    :! curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  endif
endif
"}}}
"{{{plugins
call plug#begin('~/.vim/plugged')
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-sleuth'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'itchyny/lightline.vim'
  if isdirectory('/usr/local/opt/fzf')
    Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
  else
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
    Plug 'junegunn/fzf.vim'
  endif
  Plug 'prabirshrestha/vim-lsp'
  Plug 'mattn/vim-lsp-settings'
  Plug 'mattn/vim-goimports'
  Plug 'pbrisbin/vim-mkdir'
  Plug 'mattn/vim-sonictemplate'
  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'
call plug#end()
"}}}

filetype plugin indent on
set t_Co=256
set background=dark
colorscheme delek
syntax on

"{{{keymap
let mapleader="\<Space>"
nnoremap <Leader>w :<C-u>w<CR>
nnoremap <Leader>q :<C-u>q<CR>
nnoremap <Leader><Leader>q :<C-u>q!<CR>
nnoremap <Leader><Leader><Leader>q :<C-u>qa!<CR>
vnoremap <Leader>y "+y
vnoremap <Leader>p "+p
nnoremap <Leader>p "+p
nnoremap <Leader><CR> :<C-u>noh<CR>
vmap < <gv
vmap > >gv

inoremap <C-a> <C-o>^
inoremap <C-e> <End>

noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
"}}}
"""{{{fzf
nnoremap <C-p> :<C-u>Files<CR>
"}}}

