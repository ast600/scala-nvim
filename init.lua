package.path = "./?.lua;" .. package.path

vim.opt.number = true

local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim', { ['branch'] = '0.1.x' })
Plug('scalameta/nvim-metals', { ['tag'] = 'v0.10.x', ['for'] = { 'scala', 'sbt', 'java' } })
Plug('j-hui/fidget.nvim', { ['tag'] = 'v1.6.1' })
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/nvim-cmp')
Plug('lewis6991/gitsigns.nvim', { ['tag'] = 'v1.0.2' })
Plug('navarasu/onedark.nvim')

vim.call('plug#end')
vim.cmd('silent! colorscheme onedark')

require('mytelescope').setup_bindings()
require('mycmp').setup()
require('mymetals').setup()
require('gitsigns').setup()
