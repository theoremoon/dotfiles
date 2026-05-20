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
  { src = 'https://github.com/airblade/vim-gitgutter', version = '21c977e8597c468c7dc76001389b0b430d46a4b0' },
  { src = 'https://github.com/f-person/git-blame.nvim', version = '5c536e2d4134d064aa3f41575280bc8a2a0e03d7' },
  { src = 'https://github.com/ibhagwan/fzf-lua', version = '3ff77862f6c62f7b850668435ae43aa026de8758' },
  { src = 'https://github.com/junegunn/vim-easy-align', version = '9815a55dbcd817784458df7a18acacc6f82b1241' },
  { src = 'https://github.com/mattn/emmet-vim', version = '92ef2f74f4093edc99db5e9e4cf7e40116a85bd6' },
  { src = 'https://github.com/tpope/vim-rhubarb', version = '5496d7c94581c4c9ad7430357449bb57fc59f501' },
  { src = 'https://github.com/tpope/vim-sleuth', version = 'be69bff86754b1aa5adcbb527d7fcd1635a84080' },
  { src = 'https://github.com/tpope/vim-surround', version = '3d188ed2113431cf8dac77be61b842acb64433d9' },

  { src = 'https://github.com/dense-analysis/ale', version = '2a3af30fb6a725ec7215435369b310b1d2dc4c09' },
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
