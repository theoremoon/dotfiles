"""
" ▌ ▌▜▘▙▗▌▛▀▖▞▀▖
" ▚▗▘▐ ▌▘▌▙▄▘▌
" ▝▞ ▐ ▌ ▌▌▚ ▌ ▖
"  ▘ ▀▘▘ ▘▘ ▘▝▀
"
"  My most awesome vim configuration
"  @theoldmoon0602
"""

set nocompatible

set number
set ruler
set backspace=indent,eol,start
set background=dark
set belloff=all

set softtabstop=0                            " dont mix space and tab
set tabstop=4
set shiftwidth=2
set expandtab
set smarttab                                 " insert number of shiftwidth spaces at head of line
set smartindent
set autoindent

set textwidth=0                              " dont break line (different with wrap line
let &showbreak = '+++ '                      " show wrap string
set display=truncate,uhex                    " show @@@ as (displayed) last line's first character, show unprintable character as <xx> formatted
set linebreak                                " wrap on specific characters (breakat)
set nobreakindent                            " dont insert visually space when wrap line
set whichwrap=b,s,h,l,<,>                    " BS Space h l left right can move over line
set wrap                                     " wrap long line

set complete=.,w,b,u,k,i,d,t                 " current buffer, other buffers, buffer lists, dictionary, current file and includes, same, tagfiles
set noinfercase
set completeopt=menu,menuone,noselect
set path=.,/usr/include,/usr/local/include,, " list of directory names used for file searching
set dictionary+=/usr/share/dict/words
set wildmenu                                 " use tab completion on commandline mode
set wildmode=full

set enc=utf-8
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=usc-bom,utf-8,default,latin1
set fileformat=unix                          " default is LF
set fileformats=unix,dos,mac

set hlsearch
set ignorecase
set incsearch                                " incremental search
set smartcase
set wrapscan                                 " search from top when reached bottom

set laststatus=2                             " always show status line
set signcolumn=auto

set directory=~/.vim/swapdir
set swapfile
set undodir=~/.vim/undodir
set undofile                                 " use undofile
set viminfo+=n~/.vim/viminfo
set writebackup                              " create backup file before overwriting and delete if write complete

if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif


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
  Plug 'bronson/vim-trailing-whitespace'
  Plug 'Raimondi/delimitMate'
  Plug 'junegunn/vim-easy-align'

  Plug 'scrooloose/nerdtree'
  Plug 'jistr/vim-nerdtree-tabs'
  Plug 'terryma/vim-multiple-cursors'

  Plug 'tomasiser/vim-code-dark'
  Plug 'vim-scripts/CSApprox'

  Plug 'w0rp/ale', {'do': 'pip install --user -U flake8'}
  Plug 'lifepillar/vim-mucomplete'
  Plug 'vim-scripts/grep.vim'
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'

  Plug 'sheerun/vim-polyglot'
  Plug 'hail2u/vim-css3-syntax'
  Plug 'gorodinskiy/vim-coloresque'
  Plug 'tpope/vim-haml'
  Plug 'mattn/emmet-vim'

  Plug 'jelera/vim-javascript-syntax'

  Plug 'theoldmoon0602/jedi-vim', {'branch': 'theoldmoon0602', 'do': 'pip install --user -U jedi'}
  Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}

  if isdirectory('/usr/local/opt/fzf')
          Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
  else
          Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
          Plug 'junegunn/fzf.vim'
  endif

call plug#end()

filetype plugin indent on
syntax on
colorscheme codedark

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
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

vnoremap <Leader>y "+y
vnoremap <Leader>p "+p
nnoremap <Leader>p "+p
nnoremap <Leader><CR> :<C-u>noh<CR>
nnoremap <C-p> :Files<CR>
nnoremap <leader>b :Buffers<CR>

noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <leader>. :lcd %:p:h<CR>
vmap < <gv
vmap > >gv

set hidden

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

"" Easy Align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

"" NERDTree configuration
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 50
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
nnoremap <silent> <F2> :NERDTreeFind<CR>
nnoremap <silent> <F3> :NERDTreeToggle<CR>

" grep.vim
nnoremap <silent> <leader>f :Rgrep<CR>
let Grep_Default_Options = '-IR'
let Grep_Skip_Files = '*.log *.db'
let Grep_Skip_Dirs = '.git node_modules'

"*****************************************************************************
"" Functions
"*****************************************************************************
if !exists('*s:setupWrapping')
  function s:setupWrapping()
    set wrap
    set wm=2
    set textwidth=79
  endfunction
endif

"*****************************************************************************
"" Autocmd Rules
"*****************************************************************************
"" The PC is fast enough, do syntax highlight syncing from start unless 200 lines
augroup vimrc-sync-fromstart
  autocmd!
  autocmd BufEnter * :syntax sync maxlines=200
augroup END

"" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

"" txt
augroup vimrc-wrapping
  autocmd!
  autocmd BufRead,BufNewFile *.txt call s:setupWrapping()
augroup END

"" make/cmake
augroup vimrc-make-cmake
  autocmd!
  autocmd FileType make setlocal noexpandtab
  autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
augroup END

set autoread
"" fzf.vim
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"

" The Silver Searcher
if executable('ag')
  let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
  set grepprg=ag\ --nogroup\ --nocolor
endif

" ripgrep
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif

" snippets
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsEditSplit="vertical"

" ale
let g:ale_linters = {}

" html
" for html files, 2 spaces
autocmd Filetype html setlocal ts=2 sw=2 expandtab


" javascript
let g:javascript_enable_domhtmlcss = 1

" vim-javascript
augroup vimrc-javascript
  autocmd!
  autocmd FileType javascript setl tabstop=4|setl shiftwidth=4|setl expandtab softtabstop=4
augroup END

function! s:setPipenvPath()
  let pipenv_dir = expand('%:p:h')
  while pipenv_dir != '/'
    if filereadable(l:pipenv_dir . '/Pipfile')
      let venv_path = trim(system(printf("sh -c 'cd %s; pipenv --venv'", pipenv_dir)))
      let g:jedi#virtualenv_path = venv_path
      return
    endif

    let pipenv_dir = fnamemodify(pipenv_dir, ':h')
  endwhile
endfunction


" python
" vim-python
augroup vimrc-python
  autocmd!
  autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8
      \ formatoptions+=croq softtabstop=4
      \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
  autocmd FileType python :call s:setPipenvPath()
augroup END

" jedi-vim
let g:jedi#popup_on_dot = 0
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = "<leader>d"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#rename_command = "<leader>r"
let g:jedi#show_call_signatures = "0"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#smart_auto_mappings = 0

" ale
:call extend(g:ale_linters, {
    \'python': ['flake8'], })

" mucomplete
let g:mucomplete#enable_auto_at_startup = 1
imap <silent><unique><F7> <plug>(MUcompleteCycFwd)
imap <silent><unique><F8> <plug>(MUcompleteCycBwd)

" Syntax highlight
" Default highlight is better than polyglot
let g:polyglot_disabled = ['python']
let python_highlight_all = 1


