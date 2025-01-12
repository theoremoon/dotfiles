local plug_install_path = vim.fn.stdpath 'data' .. '/site/autoload/plug.vim'
if vim.fn.empty(vim.fn.glob(plug_install_path)) > 0 then
  vim.fn.execute('!curl -fL --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -o ' .. plug_install_path)
end

-- PlugInstall
local Plug = vim.fn['plug#']
vim.call('plug#begin')
  Plug('neoclide/coc.nvim', {branch ='release'})
  Plug "github/copilot.vim"

  Plug 'dense-analysis/ale'
  Plug 'theoremoon/ale-linter-perl-use-heuristic'
vim.call('plug#end')

vim.g.coc_global_extensions = {
    'coc-tsserver',
    'coc-eslint',
    'coc-prettier',
    'coc-biome',
    'coc-go',
    'coc-svelte',
}

vim.g.copilot_filetypes = {
    yaml = true,
    xml = true,
}


-- Some servers have issues with backup files, see #649
vim.opt.backup = false
vim.opt.writebackup = false

-- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
-- delays and poor user experience
vim.opt.updatetime = 300


vim.keymap.set({ 'i' }, '<CR>', [[ coc#pum#visible() ? coc#pum#confirm() : "\<CR>" ]] , { expr = true, noremap = true, silent = true })

function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end
vim.keymap.set({"n"}, "K", '<CMD>lua _G.show_docs()<CR>', {silent = true, noremap = true})
vim.keymap.set({"n"}, "<leader>a", "<Plug>(coc-codeaction-cursor)", { silent = true, noremap = true })
vim.keymap.set({"x"}, "<leader>a", "<Plug>(coc-codeaction-selected)", { silent = true, noremap = true })
vim.keymap.set({"n"}, "<leader>r", "<Plug>(coc-rename)", { silent = true, noremap = true })
vim.keymap.set({"n"}, "gd", "<Plug>(coc-definition)", { silent = true, noremap = true })
vim.keymap.set({"n"}, "gn", "<Plug>(coc-diagnostic-next)", { silent = true, noremap = true })

-- ALE
vim.g['ale_linters'] = {
    perl = {'perlcritic', 'use-heuristic'},
    python = { 'pylint' },
    typescript = {'eslint'},
    typescriptreact = {'eslint'},
}
vim.g['ale_fixers'] = {
    typescript = {'prettier', 'eslint'},
    typescriptreact = {'prettier', 'eslint'},
    perl = {'perltidy'},
    go = { 'gofmt', 'goimports' },
    python = { 'black' },
}
vim.g['ale_fix_on_save'] = 1
vim.g['ale_lint_on_save'] = 1
vim.g['ale_linters_explicit'] = 1
