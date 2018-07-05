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
call plug#begin('~/.vim/plugged')
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'

  Plug 'junegunn/vim-easy-align'
  Plug 'terryma/vim-multiple-cursors'  " <C-n> to select same, <C-x> skip

  Plug 'maralla/completor.vim'
  Plug 'davidhalter/jedi-vim', { 'do': 'pip install -U jedi' }


  " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  " Plug 'Shougo/neosnippet.vim'
  " Plug 'Shougo/neosnippet-snippets'
  " Plug 'autozimu/LanguageClient-neovim', {
  "       \ 'branch': 'next',
  "       \ 'do': 'bash install.sh',
  "       \ }

  Plug 'itchyny/lightline.vim'

  Plug 'JesseKPhillips/d.vim', { 'for': 'd' }
  Plug 'idanarye/vim-dutyl', { 'for': 'd' }
  " Plug 'landaire/deoplete-d', { 'for': 'd' }
  
  Plug 'qnighy/satysfi.vim', { 'for': ['satysfi'] }

  Plug 'othree/html5.vim', { 'for': ['html', 'js', 'css' , 'php'] }
  Plug 'mattn/emmet-vim', { 'for': ['html', 'js', 'css' , 'php'] }
  Plug 'fatih/vim-go', { 'for': 'go' }

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

" complete
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"

""" fzf
let g:fzf_buffers_jump = 1  " jump to existing window if possible
let g:fzf_tags_command='ctags -R'

nnoremap \ :BLines<CR>
nnoremap ; :Commands<CR>
nnoremap <C-p> :Files<CR>

""" LSP
" nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" 
" """ language specific settings
" set hidden
" let g:LanguageClient_serverCommands = {
"   \'d': ['serve-d'],
"   \}
" 
" let g:LanguageClient_rootMarkers = {
"   \ 'd': ['dub.json']
"   \}

" if executable("dcd-client") && executable("dcd-server")
"   let g:deoplete#sources#d#dcd_server_autostart = 1
" else
"   let g:deoplete#sources#d#dcd_server_autostart = 0
" endif

augroup D
  autocmd!
  autocmd BufNewFile,BufRead *.d DUDCDstartServer
augroup END
let g:completor_d_omni_trigger = '(\w\w\w|\.|, |)'

" let g:deoplete#enable_at_startup = 1
" call deoplete#custom#option('auto_complete', v:true)
" call deoplete#custom#option('sources', {
"   \'_': ['buffer'],
"   \})
" call deoplete#custom#option('omni_patterns', {
"       \ 'd': '\w\w\w',
" \})
" " 'd': '[^. *\t]\.\w*',


vmap ga <Plug>(EasyAlign)

" imap <C-r>     <Plug>(neosnippet_expand_or_jump)
" smap <C-r>     <Plug>(neosnippet_expand_or_jump)
" xmap <C-r>     <Plug>(neosnippet_expand_target)
colorscheme seoul256
syntax on
