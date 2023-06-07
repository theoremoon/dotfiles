local plug_install_path = vim.fn.stdpath 'data' .. '/site/autoload/plug.vim'
if vim.fn.empty(vim.fn.glob(plug_install_path)) > 0 then
  vim.fn.execute('!curl -fL --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -o ' .. plug_install_path)
end

local Plug = vim.fn['plug#']
vim.call('plug#begin')
  Plug 'savq/paq-nvim'

  Plug 'onsails/lspkind.nvim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'ray-x/cmp-treesitter'
  Plug 'quangnguyen30192/cmp-nvim-tags'
  Plug 'hrsh7th/vim-vsnip'
  Plug 'theoremoon/cmp-auto-programming'
  Plug "zbirenbaum/copilot.lua"
  Plug "zbirenbaum/copilot-cmp"

  Plug 'dense-analysis/ale'
  Plug 'theoremoon/ale-linter-perl-use-heuristic'
vim.call('plug#end')

require("copilot").setup({
  suggestion = { enabled = false },
  panel = { enabled = false },
})
require("copilot_cmp").setup()

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
  experimental = {
    ghost_text = true,
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

