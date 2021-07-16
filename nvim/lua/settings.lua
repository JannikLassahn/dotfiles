local o = vim.o
local bo = vim.bo
local wo = vim.wo
local fn = vim.fn
local api = vim.api
local g = vim.g

-- Skip providers
g.loaded_python_provider   = 0
g.loaded_python3_provider  = 0
g.loaded_node_provider 	   = 0
g.loaded_ruby_provider	   = 0
g.loaded_perl_provider 	   = 0

g.loaded_gzip              = 1
g.loaded_tar               = 1
g.loaded_tarPlugin         = 1
g.loaded_zip               = 1
g.loaded_zipPlugin         = 1
g.loaded_getscript         = 1
g.loaded_getscriptPlugin   = 1
g.loaded_vimball           = 1
g.loaded_vimballPlugin     = 1
g.loaded_matchit           = 1
--g.loaded_matchparen        = 1
g.loaded_2html_plugin      = 1
g.loaded_logiPat           = 1
g.loaded_rrhelper          = 1
g.loaded_netrwPlugin       = 1
g.loaded_netrwSettings     = 1
g.loaded_netrwFileHandlers = 1

o.hidden = true
o.number = true
o.relativenumber = true
o.termguicolors = true
o.splitright = true
o.splitbelow = true
o.ignorecase = true
o.smartcase = true
o.backup = false
o.writebackup = false
o.swapfile = false
