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

local jetpack_install_path = vim.fn.stdpath 'data' .. '/site/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim'
if vim.fn.empty(vim.fn.glob(jetpack_install_path)) > 0 then
  vim.fn.execute('!curl -fL --create-dirs https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim -o ' .. jetpack_install_path)
end

-- JetpackSync
vim.cmd('packadd vim-jetpack')
require('jetpack.packer').add {
  {'tani/vim-jetpack'}, -- bootstrap
  {'nvim-lualine/lualine.nvim',
      config = function()
          require('lualine').setup {
              options = {
                  icons_enabled = false,
                  theme = 'auto', -- from current colorscheme
                  component_separators = { left = '|', right = '|'},
              }
          }
      end
  },
  {'lukas-reineke/indent-blankline.nvim',
      config = function()
          require('ibl').setup()
      end
  },
  {'theoremoon/cryptohack-color.vim'},
  {'mjlbach/onedark.nvim' },

  {'sheerun/vim-polyglot'},
  {'prisma/vim-prisma'},

  {'tpope/vim-fugitive'},
  {'tpope/vim-rhubarb'},
  {'airblade/vim-gitgutter',
      config = function()
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
      end
  },
  {'f-person/git-blame.nvim'},
  { 'petRUShka/vim-sage'},

  {'tpope/vim-surround'},
  {'tpope/vim-sleuth'},
  {'pbrisbin/vim-mkdir'},
  {'numToStr/Comment.nvim', config = function() require('Comment').setup() end },
  {'terryma/vim-multiple-cursors'},
  {'junegunn/vim-easy-align',
      config = function()
          vim.api.nvim_set_keymap('x', 'ga', '<Plug>(EasyAlign)', { noremap = false, silent = false })
          vim.api.nvim_set_keymap('n', 'ga', '<Plug>(EasyAlign)', { noremap = false, silent = false })
      end
  },
  {'theoremoon/CTF.vim'},
  {'mattn/emmet-vim'},
  {'soramugi/auto-ctags.vim',
      config = function()
          vim.g.auto_ctags_tags_name = 'ctags'
      end,
  },

  { 'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup {
        defaults = {
          file_ignore_patterns = { "node_modules" },
          mappings = {
            i = {
              ['<C-u>'] = false,
              ['<C-d>'] = false,
            },
          },
        },
      }
      require('telescope').load_extension 'fzf'
      vim.api.nvim_set_keymap('n', '<C-p>', [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]], { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<C-f>', [[<cmd>lua require('telescope.builtin').oldfiles({previewer = false})<CR>]], { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>g', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>s', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], { noremap = true, silent = true })
    end,
  },
  { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },

  { 'nvim-treesitter/nvim-treesitter',
    config =function()
      require('nvim-treesitter.configs').setup {
        hightlight = {
          enable = true,
        },
        indent = {
          enable = true,
        }
      }
    end,
  },
}
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

-- small utils
function _G.copybufname_to_clipboard()
  local bufname = string.sub(vim.api.nvim_buf_get_name(0), string.len(vim.loop.cwd()) + 2)
  vim.fn['setreg']('+', bufname)
  print(bufname)
end
vim.cmd [[
  command! CopyBufName lua copybufname_to_clipboard()
]]


--------

vim.env.COCVIMRC = vim.fn.stdpath("config") .. "/lua/coc.lua"
vim.env.STANDARD = vim.fn.stdpath("config") .. "/lua/standard.lua"

local use_coc = true
if use_coc then
    require("coc")
else
    require("standard")
end

