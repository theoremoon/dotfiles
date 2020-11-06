" ▌ ▌▜▘▙▗▌▛▀▖▞▀▖
" ▚▗▘▐ ▌▘▌▙▄▘▌
" ▝▞ ▐ ▌ ▌▌▚ ▌ ▖
"  ▘ ▀▘▘ ▘▘ ▘▝▀
"
"  My most awesome vim configuration
"  @theoremoon
"""

"{{{ basic settings
set nocompatible

set number
set ruler
set backspace=indent,eol,start
set belloff=all
set laststatus=2                             " always show status line
set signcolumn=yes
set cursorline
"}}}
"{{{ tab and indent
set softtabstop=0                            " dont mix space and tab
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab                                 " insert number of shiftwidth spaces at head of line
set autoindent
set smartindent
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
set fileencodings=usc-bom,utf-8,euc-jp,default,latin1
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
"{{{vim-polyglot
let g:polyglot_disabled = ['python', 'markdown']
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
    "{{{basic plugins
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-sleuth'
    Plug 'bronson/vim-trailing-whitespace'
    Plug 'Raimondi/delimitMate'  " autoclose parentheses
    Plug 'junegunn/vim-easy-align'
    Plug 'terryma/vim-multiple-cursors'
    Plug 'easymotion/vim-easymotion'
    Plug 'theoremoon/vim-eval'
    Plug 'theoremoon/vim-rex'
    Plug 'mattn/gist-vim' | Plug 'mattn/webapi-vim'
    Plug 'blueyed/vim-auto-programming', {'branch': 'neovim'}
    "}}}
    "{{{statusline
    Plug 'itchyny/lightline.vim'
    "}}}
    "{{{colorscheme
    Plug 'tomasiser/vim-code-dark'
    " Plug 'vim-scripts/CSApprox'
    Plug 'NLKNguyen/papercolor-theme'
    Plug 'kamykn/dark-theme.vim'
    Plug 'romainl/Apprentice'
    Plug 'luochen1990/rainbow'
    "}}}
    "{{{filetype plugins
    Plug 'sheerun/vim-polyglot'
    Plug 'hail2u/vim-css3-syntax'
    Plug 'gorodinskiy/vim-coloresque'  " colorcode like blue
    Plug 'tpope/vim-haml'
    Plug 'jelera/vim-javascript-syntax'
    Plug 'jparise/vim-graphql'
    Plug 'ElmCast/elm-vim', {'for': 'elm'}
    Plug 'posva/vim-vue', {'for': 'vue'}
    "}}}
    "{{{sonictemplate
    Plug 'mattn/sonictemplate-vim'
    "}}}
    "{{{fzf
    if isdirectory('/usr/local/opt/fzf')
        Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
    else
        Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
        Plug 'junegunn/fzf.vim'
    endif
    "}}}
    "{{{coc.nvim
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    "}}}
    "{{{ctrlp
    " Plug 'ctrlpvim/ctrlp.vim'
    " Plug 'mattn/ctrlp-matchfuzzy'
    "}}}
    "{{{ale
    "Plug 'dense-analysis/ale'
    "}}}
    "{{{html/css/js
    Plug 'mattn/emmet-vim', {'for': ['html', 'css', 'javascript', 'php', 'typescript', 'vue', 'svelte']}
    "}}}
    "{{{go
    Plug 'mattn/vim-goimports'
    Plug 'mattn/vim-goaddtags'
    "}}}
call plug#end()
"}}}

filetype plugin indent on
set t_Co=256
set background=dark
syntax on
colorscheme PaperColor
"{{{key mappings
let mapleader="\<Space>"
let maplocalleader=","
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
inoremap <C-b> <Left>
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

noremap <Leader>t :<C-u>vs\|:term<CR>
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>
nnoremap <Leader>. :<C-u>lcd %:p:h<CR>
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
"}}}
"{{{autoprogramming
set completefunc=autoprogramming#complete
"}}}
"{{{terminal mode settings
tnoremap <Esc> <C-\><C-n>
tnoremap jk <C-\><C-n>
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
"{{{cloudformation
au BufRead,BufNewFile *template.yaml setfiletype cloudformation.yaml
au BufRead,BufNewFile template.yml set ft=cloudformation.yaml
"}}}
"""{{{fzf.vim
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"

" The Silver Searcher
if executable('ag')
  let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
  set grepprg=ag\ --nogroup\ --nocolor
  nnoremap <Leader>g :<C-u>Ag<CR>
endif

" ripgrep
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
  nnoremap <Leader>g :<C-u>Rg<CR>
endif


" keymappings
nnoremap <C-p> :<C-u>Files<CR>

" file open in new tab or goto such tab if file is already opening
function! s:GotoOrOpen(command, ...)
  for file in a:000
    if a:command == 'e'
      exec 'e ' . file
    else
      exec 'tab drop ' . file
    endif
  endfor
endfunction
command! -nargs=+ GotoOrOpen call s:GotoOrOpen(<f-args>)

let g:fzf_action = {
      \'ctrl-t': 'GotoOrOpen tab',
      \'ctrl-v': 'vsplit',
      \'ctrl-x': 'split'
      \}
let g:fzf_buffers_jump = 1
"}}}
"{{{coc.nvim
nmap <silent><Leader>d <Plug>(coc-definition)
nmap <silent><Leader>i <Plug>(coc-implementation)
nmap <silent>K :<C-u>call <SID>show_documentation()<CR>
nmap <silent><Leader>r <Plug>(coc-rename)
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
let g:coc_global_extension = [
    \ 'coc-python',
    \ 'coc-go',
    \]
"}}}
"{{{ctrlp
" let g:ctrlp_map = '<c-p>'
" let g:ctrlp_cmd = 'CtrlP'
" let g:ctrlp_match_func = {'match': 'ctrlp_matchfuzzy#matcher'}
"}}}
"{{{vimrc
augroup vimrc-vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
"}}}
"{{{ale
" let g:ale_lint_on_text_changed = 'never'
" let g:ale_lint_on_insert_leave = 1
" let g:ale_lint_on_save = 1
" let g:ale_fix_on_save = 1
" let g:ale_set_baloons = 1
" let g:ale_completion_enabled = 0
" 
" let g:ale_python_flake8_options = '--ignore=E'
" let g:ale_fixers = {
"       \'python': ['black'],
"       \'javascript': ['prettier'],
"       \'typescript': ['prettier'],
"       \'c': ['clang-format'],
"       \'cpp': ['clang-format'],
"       \'d': ['dfmt'],
"       \'go': ['gofmt', 'goimports'],
"       \}
" let g:ale_linters = {
"     \'python': [],
" 	\ 'go': ['gofmt', 'goimports'],
"     \'javascript': ['eslint'],
"     \'typescript': ['eslint'],
"     \}
"}}}
"{{{easymotion
map <Leader> <Plug>(easymotion-prefix)
"}}}
"{{{lightline
let g:lightline = {
      \ 'active': {
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype', 'indentation' ] ]
      \ },
      \ 'component_function': {
      \   'indentation': 'SleuthIndicator',
      \ },
      \ }
"}}}
"{{{graphql
au BufNewFile,BufRead *.graphql setfiletype graphql
"}}}
"{{{go
let g:goimports=1
let g:goimports_simplify=1
"}}}
"{{{python
function! s:findRoot(target)
  let dir = getcwd()
  while 1
    let files = split(globpath(l:dir, '*'), '\n')
    for f in l:files
        if a:target == fnamemodify(f, ':t')
            return l:dir
        endif
    endfor
    if l:dir == "/"
      break
    endif
    let dir = fnamemodify(l:dir, ':h')
  endwhile
  return ""
endfunction

function! s:setVenv()
  let dir = s:findRoot('Pipfile')
  echo l:dir
  if dir != ""
    let $VIRTUAL_ENV = trim(system("cd " . l:dir . "; pipenv --venv"))
  endif

  let dir = s:findRoot('poetry.lock')
  echo l:dir
  if dir != ""
    let $VIRTUAL_ENV = trim(system("cd " . l:dir . "; poetry env list --full-path | awk '{print $1}'"))
  endif
endfunction

autocmd FileType python call s:setVenv()

"}}}
"{{{dpp
au BufNewFile,BufRead *dpp setfiletype d
"}}}
"{{{ parcel serve
autocmd FileType html,javascript,css,vue,elm,svelte setl backupcopy=yes
"}}}
"{{{sonictemplate
let g:sonictemplate_vim_template_dir = [
\ '$HOME/.vim/template'
\]

"}}}
"{{{sagemath
augroup sage
  au! BufRead,BufNewFile *.sage setfiletype python
augroup END
"}}}
"{{{vim-rex
vnoremap <Leader>r :<C-u>call rex#rex()<CR>
"}}}
