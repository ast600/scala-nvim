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
