set nocompatible
set laststatus=2
set cursorline
set number

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
  Plug 'sheerun/vim-polyglot'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'itchyny/lightline.vim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  if isdirectory('/usr/local/opt/fzf')
    Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
  else
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  endif
  Plug 'yuki-yano/fzf-preview.vim', { 'branch': 'release/rpc' }
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  if has('nvim')
    Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
  else
    Plug 'Shougo/defx.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
  endif

  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'pbrisbin/vim-mkdir'
  Plug 'mattn/vim-sonictemplate'
  Plug 'petRUShka/vim-sage'
  Plug 'mattn/emmet-vim'
  Plug 'theoremoon/cryptohack-color.vim'
  Plug 'theoremoon/CTF.vim'

  Plug 'mattn/vim-goimports'
call plug#end()
"}}}

filetype plugin indent on
set t_Co=256
set termguicolors
set background=dark
colorscheme cryptohack
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
nnoremap <C-Left> gT
nnoremap <C-Right> gt

inoremap <C-a> <C-o>^
inoremap <C-e> <End>

noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
" 選択した文字列のファイルをC-tで開く
vnoremap <C-t> <C-w>gf
"}}}
"{{{telescope.nvim
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <C-f> <cmd>Telescope oldfiles<cr>
command! Grep Telescope live_grep
nnoremap ? <cmd>Telescope grep_string<CR>
nnoremap <Leader>g <cmd>Telescope live_grep<CR>
"}}}
"{{{fzf-preview
nnoremap <Leader>s <cmd>CocCommand fzf-preview.GitStatus<CR>
" "}}}
"{{{coc
nmap K :<C-u>call <SID>show_documentation()<CR>
nmap <Leader>d <plug>(coc-definition)

nmap <Leader>r <plug>(coc-rename)
nmap <Leader>a <plug>(coc-codeaction-selected)
xmap <Leader>a <plug>(coc-codeaction-selected)
xmap <Leader>f <plug>(coc-format-selected)

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endf
let g:coc_global_extensions = ['coc-pyright', 'coc-jedi', 'coc-go', 'coc-tsserver', 'coc-fzf-preview']
"}}}
autocmd BufNewFile,BufRead *.sage setlocal filetype=sage
"{{{lightline
let g:lightline = {
\ 'colorscheme': 'default',
\ 'active': {
\   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified'] ],
\   'right': [ [ 'lineinfo' ], [ 'percent' ], [ 'fileformat', 'fileencoding', 'filetype', 'sleuth' ] ],
\ },
\ 'component_function': {
\   'sleuth': 'SleuthIndicator',
\ },
\ }
"}}}
"{{{goimports
let g:goimports = 1
let g:goimports_simplify = 1
"}}}
"{{{defx.nvim
nnoremap <Leader>f :<C-u>Defx<CR>
autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
  " Define mappings
  nnoremap <silent><buffer><expr> <CR>
  \ defx#is_directory() ?
  \ defx#do_action('open_tree', 'recursive:10') : 
  \ defx#do_action('drop')
  nnoremap <silent><buffer><expr> o
  \ defx#do_action('open', 'tabnew')
  nnoremap <silent><buffer><expr> o
  \ defx#do_action('open_tree', 'toggle')
  nnoremap <silent><buffer><expr> yy
  \ defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> q
  \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> <Space>
  nnoremap <silent><buffer><expr> j
  \ line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k
  \ line('.') == 1 ? 'G' : 'k'
  nnoremap <silent><buffer><expr> cd
  \ defx#do_action('change_vim_cwd')
endfunction
"}}}
