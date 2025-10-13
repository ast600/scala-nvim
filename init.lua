package.path = package.path .. ";./?.lua"

vim.opt.number = true

local Plug = vim.fn['plug#']

vim.call('plug#begin')
vim.o.exrc = true
vim.opt.mouse = ""

Plug('mfussenegger/nvim-dap', {['tag'] = '0.10.0'})
Plug('nvim-lua/plenary.nvim', {['tag'] = 'v0.1.4'})
Plug('nvim-telescope/telescope.nvim', {['branch'] = '0.1.x'})
Plug('scalameta/nvim-metals',
     {['tag'] = 'v0.10.x', ['for'] = {'scala', 'sbt', 'java'}})
Plug('j-hui/fidget.nvim', {['tag'] = 'v1.6.1'})
Plug('hrsh7th/cmp-nvim-lsp',
     {['commit'] = '99290b3ec1322070bcfb9e846450a46f6efa50f0'})
Plug('hrsh7th/cmp-buffer',
     {['commit'] = '3022dbc9166796b644a841a02de8dd1cc1d311fa'})
Plug('hrsh7th/nvim-cmp', {['tag'] = 'v0.0.2'})
Plug('lewis6991/gitsigns.nvim', {['tag'] = 'v1.0.2'})
Plug('navarasu/onedark.nvim',
     {['commit'] = '0e5512d1bebd1f08954710086f87a5caa173a924'})

vim.call('plug#end')
vim.cmd('silent! colorscheme onedark')

require('mytelescope').setup_bindings()
require('mycmp').setup()
require('mydap').setup()
require('mymetals').setup()
require('myfidget').setup()
require('gitsigns').setup()

vim.api.nvim_create_autocmd('TextYankPost', {
    pattern = '*',
    group = vim.api.nvim_create_augroup('highlight_yank', {clear = true}),
    desc = 'Highlight yanked block',
    callback = function() vim.highlight.on_yank({timeout = 100}) end
})

vim.api.nvim_create_autocmd({'BufEnter', 'ModeChanged'}, {
    pattern = '*',
    group = vim.api.nvim_create_augroup('setup_statusline', {clear = true}),
    desc = 'Show current mode, file and git branch on the statusline',
    callback = function()
        local mode_short_name = vim.api.nvim_get_mode()['mode']
        local mode_full_name = ''
        local git_branch = ''

        if mode_short_name == 'i' then
            mode_full_name = '[INSERT]'
        elseif mode_short_name == 'n' then
            mode_full_name = '[NORMAL]'
        elseif mode_short_name == 'R' then
            mode_full_name = '[REPLACE]'
        elseif mode_short_name:lower() == 's' then
            mode_full_name = '[SELECT]'
        elseif mode_short_name:lower() == 'v' then
            mode_full_name = '[VISUAL]'
        end

        local obj = vim.system({'git', 'branch', '--show-current'},
                               {text = true}):wait()
        if obj.code == 0 then git_branch = obj.stdout:gsub("\n$", "") end

        vim.opt.statusline = mode_full_name .. ' %f%r%q%=' .. git_branch
    end
})

vim.filetype.add({
    extension = {j2 = 'jinja'},
    filename = {['.bashrc'] = 'bash', ['.gitignore'] = 'git'},
    pattern = {['.*%.ya?ml$'] = 'yaml'}
})

vim.opt.grepprg =
    "grep --recursive --with-filename --line-number --color=never --exclude-dir='.git' --exclude-dir='.metals' --exclude-dir='target'"
vim.opt.grepformat = '%f:%l:%m'
