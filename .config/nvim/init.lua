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
  use 'theoremoon/cryptohack-color.vim'
  use 'mjlbach/onedark.nvim' 
  use 'sheerun/vim-polyglot'

  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'airblade/vim-gitgutter'
  use 'f-person/git-blame.nvim'

  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  use 'tpope/vim-surround'
  use 'tpope/vim-sleuth'
  use 'pbrisbin/vim-mkdir'
  use 'numToStr/Comment.nvim'
  use 'terryma/vim-multiple-cursors'
  use 'junegunn/vim-easy-align'
  use 'theoremoon/CTF.vim'
  use 'mattn/emmet-vim'
  use 'soramugi/auto-ctags.vim'

  use 'onsails/lspkind.nvim'
  use 'nvim-treesitter/nvim-treesitter'
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'ray-x/cmp-treesitter'
  use 'quangnguyen30192/cmp-nvim-tags'
  use 'hrsh7th/vim-vsnip'
  use { 'theoremoon/cmp-auto-programming',
    requires = {
      "neovim/nvim-lspconfig",
    }
  }
  use {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
  }
  use {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function ()
      require("copilot_cmp").setup()
    end
  }

  use 'dense-analysis/ale' 
  use 'theoremoon/ale-linter-perl-use-heuristic'

  use 'petRUShka/vim-sage'
end)
-- vim.cmd('colorscheme onedark')
vim.cmd('colorscheme cryptohack')

-- sage
vim.cmd [[
  augroup sage
    autocmd!
    autocmd BufNewFile,BufRead *.sage set filetype=python
  augroup end
]]

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

-- small utils
function _G.copybufname_to_clipboard()
  local bufname = string.sub(vim.api.nvim_buf_get_name(0), string.len(vim.loop.cwd()) + 2)
  vim.fn['setreg']('+', bufname)
  print(bufname)
end
-- vim.api.nvim_add_user_command('CopyBufName', 'lua copybufname_to_clipboard()', {})
vim.cmd [[
  command! CopyBufName lua copybufname_to_clipboard()
]]

-- plugins
require('Comment').setup()
require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'auto', -- from current colorscheme
    component_separators = { left = '|', right = '|'},
  }
}

vim.cmd [[highlight IndentBlanklineIndent1 guifg=#333333 gui=nocombine]]
require('indent_blankline').setup {
  char_highlight_list = {
    "IndentBlanklineIndent1",
  },
  show_current_context = true,
}

-- easyalign
vim.api.nvim_set_keymap('x', 'ga', '<Plug>(EasyAlign)', { noremap = false, silent = false })
vim.api.nvim_set_keymap('n', 'ga', '<Plug>(EasyAlign)', { noremap = false, silent = false })

-- vim-gitgutter
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
vim.api.nvim_set_keymap('n', '<leader>s', '<cmd>GitGutterStageHunk<CR>', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<leader>u', '<cmd>GitGutterUndoHunk<CR>', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<leader>n', '<cmd>lua GitGutterNextHunkCycle()<CR>', { noremap = true, silent = false })

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
vim.api.nvim_set_keymap('n', '<leader>s', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], { noremap = true, silent = true })

-- nvim-treesitter
require('nvim-treesitter.configs').setup {
  hightlight = {
    enable = true,
  },
  indent = {
    enable = true,
  }
}

-- auto-ctags
vim.g.auto_ctags_tags_name = 'ctags'

-- ALE
vim.g['ale_linters'] = {
  typescript = {'eslint', 'tsserver'},
  typescriptreact = {'eslint', 'tsserver'},
  perl = {'perlcritic', 'use-heuristic'},
}
vim.g['ale_fixers'] = {
  typescript = {'prettier', 'eslint'},
  typescriptreact = {'prettier', 'eslint'},
  go = {'gofmt', 'goimports'},
  perl = {'perltidy'},
}
vim.g['ale_fix_on_save'] = 1

-- nvim-cmp
local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
end

local lspkind = require('lspkind')
local cmp = require('cmp')
cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end
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
      select = false,
    },
    ['<Tab>'] = vim.schedule_wrap(function(fallback)
      if cmp.visible() and has_words_before() then
        cmp.select_next_item({behavior = cmp.SelectBehavior.Select })
      else
        fallback()
      end
    end),
    ['<S-Tab>'] = vim.schedule_wrap(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end),
  },
  sources = {
    { name = 'copilot' },
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    -- { name = 'tags', },
    -- { name = 'auto_programming'},
    { name = 'treesitter'},
    { name = 'vsnip'},
  },
  formatting = {
    format = lspkind.cmp_format({
        mode = 'symbol_text',
        menu = ({
            copilot         = "[AI]",
            nvim_lsp         = "[LSP]",
            buffer           = "[BUF]",
            tags             = "[TAG]",
            auto_programming = "[AUTO]",
            treesitter       = "[TS]",
        }),
    })
  },
}
vim.api.nvim_set_keymap('i', '<C-x><C-o>', [[<Cmd>lua require('cmp').complete()<CR>]], { noremap = true, silent = true })
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- lsp
vim.lsp.set_log_level(vim.log.levels.ERROR)
vim.o.completeopt = "menuone,noinsert"
local lspconfig = require('lspconfig')
local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { noremap=true, silent=true })
    vim.api.nvim_buf_set_keymap(bufnr, 'i', '<C-n>', [[<Cmd>lua require('cmp').complete()<CR>]], { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>a', [[<Cmd>lua vim.lsp.buf.code_action()<CR>]], { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>r', [[<Cmd>lua vim.lsp.buf.rename()<CR>]], { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', [[<Cmd>lua vim.lsp.buf.format()<CR>]], { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>d', [[<Cmd>lua vim.lsp.buf.definition()<CR>]], { noremap = true, silent = true })
end

-- nvim-lspconfigでデフォルトの設定が用意されているので適宜上書きしつつそれを使う
-- 設定している項目はneovim組み込みのlsp clientのものなのでそちらのドキュメントを見る
-- nvim-lspconfigは自動で.gitやtsconfig.jsonを探してlanguage serverを起動してくれる
if vim.fn.executable('typescript-language-server') == 1 then
  lspconfig.tsserver.setup {
      on_attach = on_attach,
      flags = {
          debounce_text_changes = 200, -- 最低でも200msごとに情報を更新する
      },
      capabilities = capabilities
  }
end
if vim.fn.executable('pylsp') == 1 then
  lspconfig.pylsp.setup {
      on_attach = on_attach,
      flags = {
          debounce_text_changes = 200, -- 最低でも200msごとに情報を更新する
      },
      capabilities = capabilities,
  }
end
if vim.fn.executable('gopls') == 1 then
  lspconfig.gopls.setup {
      on_attach = on_attach,
      flags = {
          debounce_text_changes = 200, -- 最低でも200msごとに情報を更新する
      },
      capabilities = capabilities
  }
end

