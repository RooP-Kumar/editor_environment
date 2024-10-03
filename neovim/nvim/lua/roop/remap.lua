vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>e', vim.cmd.Ex)
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>p', function() builtin.find_files(require('telescope.themes').get_dropdown({})) end, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>git', builtin.git_files, { desc = 'Telescope find git files' })
vim.keymap.set('i', '<C-k>', '<Esc>')
vim.keymap.set('n', '<C-b>', ':Neotree reveal float<CR>')

vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- command line remap
vim.keymap.set('n', '<CR>', ':')
vim.keymap.set('n', '<leader>t', ':term ')
