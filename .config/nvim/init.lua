-- vim: ts=2 sts=2 sw=2 et
vim.o.compatible = false
vim.o.number = true
vim.o.signcolumn = 'yes'

vim.o.mouse = 'a'
vim.o.breakindent = true
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.ignorecase = true
vim.o.updatetime = 200
vim.o.splitright = true
vim.o.termguicolors = true
vim.o.directory = vim.fn.expand '~/.vim/swapdir'
vim.o.undodir = vim.fn.expand '~/.vim/undodir'
-- shada(viminfo)の設定はデフォルトに任せてしまう

if vim.fn.isdirectory(vim.fn.expand '~/.vim/swapdir') ~= 1 then
  vim.fn.execute('!mkdir -p ' .. (vim.fn.expand '~/.vim/swapdir'))
end
if vim.fn.isdirectory(vim.fn.expand '~/.vim/undodir') ~= 1 then
  vim.fn.execute('!mkdir -p ' .. (vim.fn.expand '~/.vim/undodir'))
end

-- packer.nvimを使う。導入するプラグインはそんなにないので遅くて困ることもないだろう
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end
vim.cmd [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]]
local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use 'nvim-lualine/lualine.nvim'
  use 'lukas-reineke/indent-blankline.nvim'
  -- use 'theoremoon/cryptohack-color.vim'
  use 'mjlbach/onedark.nvim' 

  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'airblade/vim-gitgutter'

  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  use 'tpope/vim-surround'
  use 'pbrisbin/vim-mkdir'
  use 'numToStr/Comment.nvim'
  use 'terryma/vim-multiple-cursors'
  use 'theoremoon/CTF.vim'

  use 'nvim-treesitter/nvim-treesitter'
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'ray-x/cmp-treesitter'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'lukas-reineke/cmp-rg'

  use 'dense-analysis/ale'

  use 'petRUShka/vim-sage'
end)
vim.cmd('colorscheme onedark')

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

-- plugins
require('Comment').setup()
require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'auto', -- from current colorscheme
    component_separators = { left = '|', right = '|'},
  }
}
require('indent_blankline').setup()
-- vim-gitgutter
vim.api.nvim_set_keymap('n', '<leader>s', '<Plug>(GitGutterStageHunk)', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<leader>u', '<Plug>(GitGutterUndoHunk)', { noremap = true, silent = false })

-- telescope
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}
require('telescope').load_extension 'fzf'

--Add leader shortcuts
vim.api.nvim_set_keymap('n', '<C-p>', [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-f>', [[<cmd>lua require('telescope.builtin').oldfiles({previewer = false})<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>g', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], { noremap = true, silent = true })

-- nvim-treesitter
require('nvim-treesitter.configs').setup {
  hightlight = {
    enable = true,
  },
  indent = {
    enable = true,
  }
}
-- nvim-cmp
local cmp = require('cmp')
cmp.setup {
  completion = {
    autocomplete = false,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'treesitter' },
    { name = 'rg' },
  },
}
vim.api.nvim_set_keymap('i', '<C-x><C-o>', [[<Cmd>lua require('cmp').complete()<CR>]], { noremap = true, silent = true })
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- lsp
vim.o.completeopt = "menuone,noinsert"
local lspconfig = require('lspconfig')
local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { noremap=true, silent=true }
    vim.api.nvim_buf_set_keymap('n', 'K', '<cmd>lua vim.slp.buf.hover()<CR>', opts)
end

-- nvim-lspconfigでデフォルトの設定が用意されているので適宜上書きしつつそれを使う
-- 設定している項目はneovim組み込みのlsp clientのものなのでそちらのドキュメントを見る
-- nvim-lspconfigは自動で.gitやtsconfig.jsonを探してlanguage serverを起動してくれる
lspconfig.tsserver.setup {
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 200, -- 最低でも200msごとに情報を更新する
    },
    capabilities = capabilities
}
