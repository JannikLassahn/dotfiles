local g = vim.g
local map = vim.api.nvim_set_keymap

g.mapleader = ' '
map('n', '<Leader>w', ':w<CR>', { noremap = true, silent = false })
map('n', '<Leader>q', ':q<CR>', { noremap = true, silent = false })

map('n', '<C-Up>', ':resize -2<CR>', { silent = true })
map('n', '<C-Down>', ':resize +2<CR>', { silent = true })
map('n', '<C-Left>', ':vertical resize -2<CR>', { silent = true })
map('n', '<C-Right>', ':vertical resize +2<CR>', { silent = true })

map('i', 'jk', '<ESC>', { noremap = true, silent = true })

-- Disable Arrow Keys
map('i', '<Up>',    '<NOP>', { noremap = true })
map('i', '<Down>',  '<NOP>', { noremap = true })
map('i', '<Left>',  '<NOP>', { noremap = true })
map('i', '<Right>', '<NOP>', { noremap = true })
map('n', '<Up>',    '<NOP>', { noremap = true })
map('n', '<Down>',  '<NOP>', { noremap = true })
map('n', '<Left>',  '<NOP>', { noremap = true })
map('n', '<Right>', '<NOP>', { noremap = true })
