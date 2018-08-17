"""
" General Options
"""
filetype plugin on
filetype indent on

" :W sudo saves the file 
" (useful for handling the permission-denied error)
command! W w !sudo tee % > /dev/null

if &compatible
set nocompatible
endif
set wildmenu
set wildignore=*.o,*~,*.pyc
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
set ruler  "Always show current position
set number
set cmdheight=2  " Height of the command bar
set hid  " A buffer becomes hidden when it is abandoned
set backspace=eol,start,indent  " Configure backspace so it acts as it should act
set whichwrap+=<,>,h,l
set ignorecase  " Ignore case when searching
set smartcase  " When searching try to be smart about cases 
set hlsearch  " Highlight search results
set incsearch  " Makes search act like search in modern browsers
set lazyredraw  " Don't redraw while executing macros (good performance config)
set magic  " For regular expressions turn magic on
set showmatch  " Show matching brackets when text indicator is over them
set mat=2  " How many tenths of a second to blink when matching brackets
set noerrorbells  " No annoying sound on errors
set novisualbell
set t_vb=
set tm=500
set foldcolumn=1  " Add a bit extra margin to the left
set encoding=utf8  " Set utf8 as standard encoding and en_US as the standard language
set ffs=unix,dos,mac  " Use Unix as the standard file type
set expandtab  " Use spaces instead of tabs
set smarttab  " Be smart when using tabs ;)
set shiftwidth=4  " 1 tab == 4 spaces
set tabstop=4
set lbr  " Linebreak on 500 characters
set tw=500
set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines
try " Specify the behavior when switching between buffers 
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry
set laststatus=2  " Always show the status line

