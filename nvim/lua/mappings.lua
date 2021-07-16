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

-- <ctrl-s> to Save
map('n', '<C-S>', '<esc>:update<cr>', { silent = true })
map('v', '<C-S>', '<esc>:update<cr>', { silent = true })
map('i', '<C-S>', '<esc>:update<cr>', { silent = true })

-- Disable Arrow Keys
map('i', '<Up>',    '<NOP>', { noremap = true })
map('i', '<Down>',  '<NOP>', { noremap = true })
map('i', '<Left>',  '<NOP>', { noremap = true })
map('i', '<Right>', '<NOP>', { noremap = true })
map('n', '<Up>',    '<NOP>', { noremap = true })
map('n', '<Down>',  '<NOP>', { noremap = true })
map('n', '<Left>',  '<NOP>', { noremap = true })
map('n', '<Right>', '<NOP>', { noremap = true })

map('n', '<A-j>', ':m .+1<CR>==', { noremap = true })
map('n', '<A-k>', ':m .-1<CR>==', { noremap = true })

map("i", "<C-Space>", "compe#complete()", {noremap = true, silent = true, expr = true})
map("i", "<CR>", "compe#confirm('<CR>')", {noremap = true, silent = true, expr = true})
map("i", "<C-e>", "compe#close('<C-e>')", {noremap = true, silent = true, expr = true})
map("i", "<C-f>", "compe#scroll({ 'delta': +4 })", {noremap = true, silent = true, expr = true})
map("i", "<C-d>", "compe#scroll({ 'delta': -4 })", {noremap = true, silent = true, expr = true})

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
