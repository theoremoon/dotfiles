"""
" Management Plugins
"   using dein.nvim
"""

if !isdirectory(expand("~/.cache/dein"))
    :! curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > /tmp/installer.sh && sh /tmp/installer.sh ~/.cache/dein
endif

set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
if dein#load_state('~/.cache/dein')
    call dein#begin('~/.cache/dein')
    call dein#add('~/.cache/dein')

    call dein#add('Shougo/denite.nvim')
    call dein#add('Shougo/deoplete.nvim')
    if !has('nvim')
        call dein#add('roxma/nvim-yarp')
        call dein#add('roxma/vim-hug-neovim-rpc')
    endif

    call dein#add('terryma/vim-expand-region')
    call dein#add('terryma/vim-multiple-cursors')
    call dein#add('maxbrunsfeld/vim-yankstack')
    call dein#add('w0rp/ale')
    call dein#add('morhetz/gruvbox')

    call dein#add('davidhalter/jedi-vim', {'on_ft': 'python', 'build': 'pip install jedi'})
    call dein#add('zchee/deoplete-jedi', {'on_ft': 'python'})

    call dein#add('mattn/emmet-vim', {'on_ft': ['html', 'js', 'css', 'twig', 'htmldjango']})
    call dein#add('evidens/vim-twig', {'on_ft': ['html', 'js', 'css', 'twig']})

    call dein#add('rust-lang/rust.vim', {'on_ft': 'rust'})
    call dein#add('sebastianmarkow/deoplete-rust', {'on_ft': 'rust'})

    call dein#end()
    call dein#save_state()
endif

command! Deinstall call dein#install()

"" denite
nnoremap <C-p> :<C-u>Denite -path=<c-r>=expand("%:p:h")<cr> file_rec<CR>
nnoremap <Leader>o :<C-u>Denite file_rec<CR>

"" deoplete
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option({
    \'ignore_case': v:true,
    \ })
call deoplete#custom#option('keyword_patterns', {
    \ '_': '[a-zA-Z_]\k*',
    \})

"" vim-expand-region
xmap v <Plug>(expand_region_expand)
xmap V <Plug>(expand_region_shrink)
let g:expand_region_text_objects = {
      \ 'iw'  :0,
      \ 'iW'  :0,
      \ 'i"'  :0,
      \ 'i''' :0,
      \ 'i]'  :1,
      \ 'ib'  :1,
      \ 'iB'  :1,
      \ 'il'  :1,
      \ 'ii'  :1,
      \ 'ip'  :0,
      \ 'ie'  :0,
      \ }

"" vim-yankstack
nmap , <Plug>yankstack_substitute_older_paste
nmap <C-,> <Plug>yankstack_substitute_newer_paste

"" ale
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\}
