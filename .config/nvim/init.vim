"""
" ▌ ▌▜▘▙▗▌▛▀▖▞▀▖
" ▚▗▘▐ ▌▘▌▙▄▘▌
" ▝▞ ▐ ▌ ▌▌▚ ▌ ▖
"  ▘ ▀▘▘ ▘▘ ▘▝▀
"
"  My most awesome vim configuration
"  @theoldmoon0602
"""

""" options 
set nocompatible
set whichwrap=b,s,h,l,<,>  " BS Space h l left right can move over line
set path=.,/usr/include,/usr/local/include,,  " list of directory names used for file searching
set noautochdir  " do not change directory when open file
set wrapscan  " search from top when reached bottom
set incsearch  " incremental search
set regexpengine=0  " automatically select regexp engine
set noignorecase  " case-sensitive search
" set nosmartcase  " non-case-sensitive search even Uppercase is included
set tagbsearch  " use binary search for tags file
set taglength=0  " whole of tag name has meaning
" set tags  " use default value
set tagcase=ignore  " ignore case when searching tags file
set wrap  " wrap long line
set linebreak  " wrap on specific characters (breakat)
set nobreakindent  " dont insert visually space when wrap line
let &showbreak = '+++ '  " show wrap string
set display=truncate,uhex  " show @@@ as (displayed) last line's first character, show unprintable character as <xx> formatted
set number
set background=dark
set nospell  " no shellcheck
set spellsuggest=best
set laststatus=2  " always show status line
" set statusline  " managed by plugin
set ruler 
set belloff=all
set undofile  " use undofile
set undodir=~/.vim/undodir
set textwidth=0  " dont break line (different with wrap line
set backspace=indent,eol,start
set complete=.,w,b,u,k,i,d,t  "current buffer, other buffers, buffer lists, dictionary, current file and includes, same, tagfiles
set dictionary+=/usr/share/dict/words
set tabstop=2
set shiftwidth=2
set smarttab  " insert number of shiftwidth spaces at head of line
set softtabstop=0  " dont mix space and tab
set shiftround  " align indent following shiftwidth when << and >>
set expandtab  " use spaces instead of tab
set autoindent
set smartindent
set fileformat=unix  " default is LF
set fileformats=unix,dos  " accept LF and CRLF
set writebackup  " create backup file before overwriting and delete if write complete
set swapfile
set directory=~/.vim/swapdir
set enc=utf-8
set fileencodings=usc-bom,utf-8,default,latin1
set viminfo+=n~/.vim/viminfo
set signcolumn=yes
set wildmenu  " use tab completion on commandline mode
set wildmode=full

if !isdirectory(expand("~/.vim/backupdir"))
  call mkdir(expand("~/.vim/backupdir"))
endif
if !isdirectory(expand("~/.vim/swapdir"))
  call mkdir(expand("~/.vim/swapdir"))
endif
if !isdirectory(expand("~/.vim/undodir"))
  call mkdir(expand("~/.vim/undodir"))
endif

""" plugins
if has('nvim')
  if !filereadable(expand("~/.local/share/nvim/site/autoload/plug.vim"))
    :! curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  endif
else
  if !filereadable(expand("~/.vim/autoload/plug.vim"))
    :! curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  endif
endif

call plug#begin('~/.vim/plugged')
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-surround'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'

  Plug 'junegunn/vim-easy-align'
  Plug 'terryma/vim-multiple-cursors'  " <C-n> to select same, <C-x> skip

  Plug 'itchyny/lightline.vim'
  Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries' }
  Plug 'sheerun/vim-polyglot'
  Plug 'othree/html5.vim', { 'for': ['html', 'js', 'css' , 'php'] }
  Plug 'mattn/emmet-vim', { 'for': ['html', 'js', 'css' , 'php', 'htmldjango'] }

  Plug 'prabirshrestha/vim-lsp'
  Plug 'prabirshrestha/async.vim'

  " Plug 'qnighy/satysfi.vim', { 'for': 'satysfi' }
  " Plug 'theoldmoon0602/satysfi.vim', { 'for': 'satysfi', 'branch': 'patch-1' }

  " Plug 'theoldmoon0602/ale', { 'branch': 'satysfi' }
  " Plug '/home/theoldmoon0602/space/ale'

  Plug 'junegunn/seoul256.vim'
call plug#end()
""" mappings
let mapleader="\<Space>"
let maplocalleader="\<Space>"

inoremap jk <Esc>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader><Leader>q :qa!<CR>
nnoremap <Leader>e :source $MYVIMRC<CR>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
inoremap <C-b> <Left>
vnoremap <Leader>y "+y
vnoremap <Leader>p "+p
nnoremap <Leader>p "+p
nnoremap <Leader><CR> :<C-u>noh<CR>

""" fzf
let g:fzf_buffers_jump = 1  " jump to existing window if possible
let g:fzf_tags_command='ctags -R'

command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)
nnoremap <Leader>\ :GGrep<CR>
nnoremap \ :BLines<CR>
nnoremap ; :Commands<CR>
nnoremap <C-p> :Files<CR>

" let b:ale_linters = {'satysfi': ['satysfi']}
let g:polyglot_disabled = ['go']

if executable('pyls')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
    autocmd Filetype python setlocal omnifunc=lsp#complete
endif

vmap ga <Plug>(EasyAlign)

colorscheme seoul256
syntax on
filetype on
filetype plugin on
filetype indent on
