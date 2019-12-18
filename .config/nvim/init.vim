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
    Plug 'justinmk/vim-dirvish'
    Plug 'easymotion/vim-easymotion'
    Plug 'theoldmoon0602/vim-eval'
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
    "{{{vim-lsp
    Plug 'prabirshrestha/asyncomplete.vim'
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
    Plug 'dense-analysis/ale'
    "}}}
    "{{{html/css/js
    Plug 'mattn/emmet-vim', {'for': ['html', 'css', 'javascript', 'php', 'typescript', 'vue']}
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

noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>
nnoremap <Leader>. :<C-u>lcd %:p:h<CR>
imap <C-f> <Plug>(asyncomplete_force_refresh)
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
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
endif

" ripgrep
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif


" keymappings
nnoremap <C-p> :<C-u>Files<CR>

"}}}
"{{{vimrc
augroup vimrc-vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
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
      \'javascript': ['prettier'],
      \'typescript': ['prettier'],
      \'c': ['clang-format'],
      \'cpp': ['clang-format'],
      \'d': ['dfmt'],
      \'go': ['gofmt', 'goimports'],
      \}
let g:ale_linters = {
    \'python': [],
	\ 'go': ['gofmt', 'goimports'],
    \'javascript': ['eslint'],
    \'typescript': ['eslint'],
    \}
"}}}
"{{{vim-polyglot
let g:polyglot_disabled = ['python', 'go']
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
"{{{vim-lsp
let g:lsp_diagnostics_enabled = 0
let g:lsp_highlights_enabled = 0
let g:lsp_textprop_enabled = 1
let g:lsp_text_edit_enabled = 0 "https://github.com/prabirshrestha/asyncomplete.vim/issues/156
let g:lsp_log_file = expand('~/vim-lsp.log')
nnoremap <Leader>r :<C-u>LspRename<CR>

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
endfunction

if executable('pyls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
    autocmd FileType python setlocal omnifunc=lsp#complete
    autocmd FileType python call s:setVenv()
endif
if executable('dls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'dls',
        \ 'cmd': {server_info->['dls']},
        \ 'whitelist': ['d'],
        \ })
    autocmd FileType d setlocal omnifunc=lsp#complete
endif
if executable('serve-d')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'serve-d',
        \ 'cmd': {server_info->['serve-d']},
        \ 'whitelist': ['d'],
        \ })
    autocmd FileType d setlocal omnifunc=lsp#complete
endif
if executable('gopls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'gopls',
        \ 'cmd': {server_info->['gopls']},
        \ 'whitelist': ['go'],
        \ 'workspace_config': { 'gopls': {
        \   'staticcheck': v:true,
        \   'completionDocumentation': v:true,
        \   'hoverKind': "FullDocumentation",
        \   'usePlaceholders': v:true,
        \ }},
        \ })
    autocmd FileType go setlocal omnifunc=lsp#complete
endif
if executable('ocaml-language-server')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'ocaml-language-server',
        \ 'cmd': {server_info->['ocaml-language-server', '--stdio']},
        \ 'whitelist': ['ocaml'],
        \ })
endif
if executable('vls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'vls',
        \ 'cmd': {server_info->['vls']},
        \ 'whitelist': ['vue'],
        \ })
endif
if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rls']},
        \ 'workspace_config': {'rust': {'clippy_preference': 'on'}},
        \ 'whitelist': ['rust'],
        \ })
    autocmd FileType rust setlocal omnifunc=lsp#complete
endif

"}}}
"{{{elm
if &ft == "elm"
    let g:ale_completion_enabled = 1
    call ale#completion#Enable()
endif
"}}}
"{{{dpp
au BufNewFile,BufRead *dpp setfiletype d
"}}}
"{{{ parcel serve
autocmd FileType html,javascript,css,vue setl backupcopy=yes
"}}}
"{{{sonictemplate
let g:sonictemplate_vim_template_dir = [
\ '$HOME/.vim/template'
\]

"}}}
