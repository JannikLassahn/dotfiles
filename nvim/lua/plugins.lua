local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
	execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
	execute 'packadd packer.nvim'
end

local init = function()
	use 'wbthomason/packer.nvim'

	use {
		'neovim/nvim-lspconfig',
		config = function() 
			require('plugins.lspconfig')
		end
	}
	use 'kabouzeid/nvim-lspinstall'
	use {'glepnir/lspsaga.nvim', cmd = 'Lspsaga' } 
	use { 
		'hrsh7th/nvim-compe', 
		event = 'InsertEnter', 
		config = require('plugins.compe').config 
	}

	use {
		'simrat39/symbols-outline.nvim',
		setup = require('plugins.outline').setup,
		cmd = { 'SymbolsOutline', 'SymbolsOutlineOpen' }
	}

	use {
		'nvim-telescope/telescope.nvim',
		cmd = 'Telescope',
		setup = require('plugins.telescope').setup,
		config = require('plugins.telescope').config,
		requires = {
			{'nvim-lua/popup.nvim', opt = true},
			{'nvim-lua/plenary.nvim',opt = true},
			{'nvim-telescope/telescope-fzy-native.nvim',opt = true},
		}
	}
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		event = 'BufRead',
		config = require('plugins.treesitter').config
	}

	use 'kyazdani42/nvim-web-devicons'
	use {
		'kyazdani42/nvim-tree.lua',
		cmd = {'NvimTreeToggle','NvimTreeOpen'},
		setup = require('plugins.nvim-tree').setup,
		config = require('plugins.nvim-tree').config,
    		requires = 'kyazdani42/nvim-web-devicons'
	}

	use {
		'glepnir/galaxyline.nvim',
		branch = 'main',
		config = function()
			require 'plugins.statusline'
		end,
		requires = 'kyazdani42/nvim-web-devicons'
	}

	use {
		'glepnir/dashboard-nvim',
		config = require('plugins.dashboard').config
	}

	use {
		'b3nj5m1n/kommentary',
		config = require('plugins.kommentary').config,
		keys = {'gcc', 'gc'}
	}

	-- Theming
	use {
		'glepnir/zephyr-nvim',
		config = [[vim.cmd('colorscheme zephyr')]]
	}
end

return require('packer').startup(init)
