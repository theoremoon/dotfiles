-- vim: ts=2 sts=2 sw=2 et
vim.o.compatible = false
vim.o.number = true
vim.o.signcolumn = 'yes'

vim.o.cursorline = true
vim.o.mouse = 'a'
vim.o.breakindent = true
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.ignorecase = true
vim.o.updatetime = 200
vim.o.splitright = true
vim.o.termguicolors = true
vim.o.undofile = true
vim.o.directory = vim.fn.expand '~/.vim/swapdir'
vim.o.undodir = vim.fn.expand '~/.vim/undodir'
vim.o.tags = vim.fn.expand 'ctags;~'
-- shada(viminfo)の設定はデフォルトに任せてしまう

if vim.fn.isdirectory(vim.fn.expand '~/.vim/swapdir') ~= 1 then
  vim.fn.execute('!mkdir -p ' .. (vim.fn.expand '~/.vim/swapdir'))
end
if vim.fn.isdirectory(vim.fn.expand '~/.vim/undodir') ~= 1 then
  vim.fn.execute('!mkdir -p ' .. (vim.fn.expand '~/.vim/undodir'))
end


vim.pack.add({
  'https://github.com/airblade/vim-gitgutter',
  'https://github.com/f-person/git-blame.nvim',
  'https://github.com/ibhagwan/fzf-lua',
  'https://github.com/junegunn/vim-easy-align',
  'https://github.com/mattn/emmet-vim',
  'https://github.com/tpope/vim-fugitive',
  'https://github.com/tpope/vim-rhubarb',
  'https://github.com/tpope/vim-sleuth',
  'https://github.com/tpope/vim-surround',

  'https://github.com/dense-analysis/ale',
  'https://github.com/theoremoon/ale-linter-perl-use-heuristic',

  'https://github.com/theoremoon/CTF.vim',
  'https://github.com/theoremoon/cryptohack-color.vim',
})
vim.cmd('colorscheme cryptohack')

-- keymaps
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.api.nvim_set_keymap('n', '<leader>w', ':<C-u>w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>q', ':<C-u>q<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader><leader>q', ':<C-u>q!<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader><leader><leader>q', ':<C-u>qa!<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>y', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>p', '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>p', '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader><CR>', ':<C-u>noh<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>h', '<plug>(SynStack)', { noremap = true, silent = true })

vim.api.nvim_set_keymap('v', '<', '<gv', { noremap = false, silent = true })
vim.api.nvim_set_keymap('v', '>', '>gv', { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', '<C-Left>', 'gt', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-Right>', 'gT', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-a>', '<Home>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-a>', '<Home>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-e>', '<End>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-e>', '<End>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('i', '<C-b>', '<Left>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-j>', '<Down>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-k>', '<Up>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-l>', '<Right>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>b', ':<C-u>GitBlameOpenCommitURL<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<C-p>', [[<cmd>lua require('fzf-lua').files()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-f>', [[<cmd>lua require('fzf-lua').resume()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>g', [[<cmd>lua require('fzf-lua').live_grep_native()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>s', [[<cmd>lua require('fzf-lua').grep_cword()<CR>]], { noremap = true, silent = true })

vim.api.nvim_set_keymap('x', 'ga', '<Plug>(EasyAlign)', { noremap = false, silent = false })
vim.api.nvim_set_keymap('n', 'ga', '<Plug>(EasyAlign)', { noremap = false, silent = false })

vim.api.nvim_set_keymap('n', '<leader>n', '<cmd>GitGutterNextHunkCycle<CR>', { noremap = false, silent = false })

function _G.GitGutterNextHunkCycle()
  local current_window = 0
  local initialrow, initialcol = unpack(vim.api.nvim_win_get_cursor(current_window))

  vim.fn['gitgutter#hunk#next_hunk'](1)
  local afterrow, _ = unpack(vim.api.nvim_win_get_cursor(current_window))
  if afterrow == initialrow then
    vim.api.nvim_win_set_cursor(current_window, {1, 0})
    vim.fn['gitgutter#hunk#next_hunk'](1)
    local afterrow2, _ = unpack(vim.api.nvim_win_get_cursor(current_window))
    if afterrow2 == 1 then
      vim.api.nvim_win_set_cursor(current_window, {1, 0})
    end
  end
end

-- small utils
function _G.copybufname_to_clipboard()
  local bufname = string.sub(vim.api.nvim_buf_get_name(0), string.len(vim.loop.cwd()) + 2)
  vim.fn['setreg']('+', bufname)
  print(bufname)
end
vim.cmd [[
  command! CopyBufName lua copybufname_to_clipboard()
]]

-- ALE
vim.g['ale_linters'] = {
  typescript = {'eslint', 'tsserver'},
  typescriptreact = {'eslint', 'tsserver'},
  perl = {'perlcritic', 'use-heuristic'},
}
vim.g['ale_fixers'] = {
  typescript = {'prettier', 'eslint', 'deno'},
  typescriptreact = {'prettier', 'eslint', 'deno'},
  go = {'gofmt', 'goimports'},
  perl = {'perltidy'},
}
vim.g['ale_fix_on_save'] = 1
