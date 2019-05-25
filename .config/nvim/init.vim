"""
" ▌ ▌▜▘▙▗▌▛▀▖▞▀▖
" ▚▗▘▐ ▌▘▌▙▄▘▌
" ▝▞ ▐ ▌ ▌▌▚ ▌ ▖
"  ▘ ▀▘▘ ▘▘ ▘▝▀
"
"  My most awesome vim configuration
"  @theoldmoon0602
"""

"{{{ basic settings
set nocompatible

set number
set ruler
set backspace=indent,eol,start
set background=dark
set belloff=all
set laststatus=2                             " always show status line
set signcolumn=yes
"}}}
"{{{ tab and indent
set softtabstop=0                            " dont mix space and tab
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab                                 " insert number of shiftwidth spaces at head of line
set smartindent
set autoindent
"}}}
"{{{ text wrapping
set textwidth=0                              " dont break line (different with wrap line{{{{{{
let &showbreak = '+++ '                      " show wrap string
set display=truncate,uhex                    " show @@@ as (displayed) last line's first character, show unprintable character as <xx> formatted
set linebreak                                " wrap on specific characters (breakat)
set nobreakindent                            " dont insert visually space when wrap line
set whichwrap=b,s,h,l,<,>                    " BS Space h l left right can move over line
set wrap                                     " wrap long line}}}}}}
"}}}
"{{{ completion
set complete=.,w,b,u,k,i,d,t                 " current buffer, other buffers, buffer lists, dictionary, current file and includes, same, tagfiles
set noinfercase
set completeopt=menu,menuone,noselect
set path=.,/usr/include,/usr/local/include,, " list of directory names used for file searching
set dictionary+=/usr/share/dict/words
set wildmenu                                 " use tab completion on commandline mode
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__,node_modules
"}}}
"{{{ encoding & newline marker
if &modifiable
  set encoding=utf-8
  set fileformat=unix                          " default is LF
  set fileencoding=utf-8
endif
set fileencodings=usc-bom,utf-8,default,latin1
set fileformats=unix,dos,mac
"}}}
"{{{ search
set hlsearch
set ignorecase
set incsearch                                " incremental search
set smartcase
set wrapscan                                 " search from top when reached bottom
"}}}
"{{{ undo/backup/viminfo
set directory=~/.vim/swapdir
set swapfile
set undodir=~/.vim/undodir
set undofile                                 " use undofile
set viminfo+=n~/.vim/viminfo
set writebackup                              " create backup file before overwriting and delete if write complete
if !isdirectory(expand("~/.vim/backupdir"))
  call mkdir(expand("~/.vim/backupdir"))
endif
if !isdirectory(expand("~/.vim/swapdir"))
  call mkdir(expand("~/.vim/swapdir"))
endif
if !isdirectory(expand("~/.vim/undodir"))
  call mkdir(expand("~/.vim/undodir"))
endif
"}}}
if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif
"{{{plugins
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
    "{{{basic plugins
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'bronson/vim-trailing-whitespace'
    Plug 'Raimondi/delimitMate'  " autoclose parentheses
    Plug 'junegunn/vim-easy-align'
    Plug 'osyo-manga/vim-brightest'  " highlight words under cursor
    Plug 'terryma/vim-multiple-cursors'
    Plug 'rhysd/clever-f.vim'
    Plug 'justinmk/vim-dirvish'
    Plug 'easymotion/vim-easymotion'
    "}}}
    "{{{statusline
    Plug 'itchyny/lightline.vim'
    "}}}
    "{{{colorscheme
    Plug 'tomasiser/vim-code-dark'
    Plug 'vim-scripts/CSApprox'
    "}}}

    "{{{filetype plugins
    Plug 'sheerun/vim-polyglot'
    Plug 'hail2u/vim-css3-syntax'
    Plug 'gorodinskiy/vim-coloresque'  " colorcode like blue
    Plug 'tpope/vim-haml'
    Plug 'jelera/vim-javascript-syntax'
    "}}}

    Plug 'prabirshrestha/asyncomplete.vim'
    "{{{vim-lsp
    Plug 'prabirshrestha/async.vim'
    Plug 'prabirshrestha/vim-lsp'
    Plug 'prabirshrestha/asyncomplete-lsp.vim'
    "}}}
    "{{{fzf
    if isdirectory('/usr/local/opt/fzf')
        Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
    else
        Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
        Plug 'junegunn/fzf.vim'
    endif
    "}}}
    "{{{ale
    Plug 'w0rp/ale'
    "}}}
    "{{{html/css/js
    Plug 'mattn/emmet-vim', {'for': ['html', 'css', 'javascript', 'php']}
    "}}}
call plug#end()
"}}}

filetype plugin indent on
syntax on
colorscheme codedark
"{{{key mappings
let mapleader="\<Space>"
let maplocalleader="\<Space>"

inoremap jk <Esc>
nnoremap <Leader>w :<C-u>w<CR>
nnoremap <Leader>q :<C-u>q<CR>
nnoremap <Leader><Leader>q :<C-u>qa!<CR>
nnoremap <Leader>e :<C-u>source $MYVIMRC<CR>
vnoremap <Leader>y "+y
vnoremap <Leader>p "+p
nnoremap <Leader>p "+p
nnoremap <Leader><CR> :<C-u>noh<CR>
vmap < <gv
vmap > >gv
nnoremap n nzzzv
nnoremap N Nzzzv

nnoremap <C-a> <Home>
nnoremap <C-e> <End>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-a> <C-o>^
inoremap <C-e> <End>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>
nnoremap <leader>. :<C-u>lcd %:p:h<CR>
"}}}
"""{{{Easy Align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
"}}}
"""{{{ Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END
"}}}
"""{{{make/cmake
augroup vimrc-make-cmake
  autocmd!
  autocmd FileType make setlocal noexpandtab
  autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
augroup END
"}}}
"""{{{fzf.vim
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"

" The Silver Searcher
if executable('ag')
  let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
  set grepprg=ag\ --nogroup\ --nocolor
  nnoremap <Leader>f :<C-u>Ag<CR>
endif

" ripgrep
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
  nnoremap <Leader>f :<C-u>Rg<CR>
endif


" keymappings
nnoremap <C-p> :<C-u>Files<CR>

"}}}
"{{{c
if executable('clangd')
    au User lsp_setup call lsp#register_server({
                \'name': 'clangd',
                \'cmd': {server_info->['clangd']},
                \'whitelist': ['c', 'cpp'],
                \})
endif
"}}}
"{{{d
if executable('serve-d')
    au User lsp_setup call lsp#register_server({
                \'name': 'serve-d',
                \'cmd': {server_info->['serve-d']},
                \'whitelist': ['d'],
                \})
endif
"}}}
"{{{python
if executable('pyls')
    au User lsp_setup call lsp#register_server({
                \'name': 'pyls',
                \'cmd': {server_info->['pyls']},
                \'whitelist': ['python'],
                \})
endif
"}}}
"{{{vimrc
augroup vimrc-vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
"}}}
"{{{trailing-whitespace
augroup trailing-whitespace
    autocmd BufWritePre * :FixWhitespace
augroup END
"}}}
"{{{ale
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1
let g:ale_set_baloons = 1
let g:ale_completion_enabled = 0

let g:ale_python_flake8_options = '--ignore=E'
let g:ale_fixers = {
      \'python': ['black'],
      \'c': ['clang-format'],
      \'cpp': ['clang-format'],
      \}
let g:ale_linters = {
    \'python': ['flake8']
    \}
"}}}
"{{{vim-lsp
let g:lsp_diagnostics_enabled = 0
set omnifunc=lsp#complete
"}}}
"{{{asyncomplete.vim
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"
"}}}
"{{{clever-f
let g:clever_f_smart_case = 1
let g:clever_f_across_no_line = 1
"}}}
"{{{vim-polyglot
let g:polyglot_disabled = ['python']
"}}}
"{{{easymotion
map <Leader> <Plug>(easymotion-prefix)
"}}}
"{{{lightline
function! GetLSPServer()
    let servers = lsp#get_whitelisted_servers()
    let runnings = []
    for s in l:servers
        if lsp#get_server_status(s) == "running"
            call add(l:runnings, s)
        endif
    endfor
    return join(l:runnings, "/")
endf
let g:lightline = {
      \ 'active': {
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype', 'lspserver' ] ]
      \ },
      \ 'component_function': {
      \   'lspserver': 'GetLSPServer'
      \ },
      \ }
"}}}
