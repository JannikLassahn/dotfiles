local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
	execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
	execute 'packadd packer.nvim'
end

local init = function()
	use 'wbthomason/packer.nvim'

	use {"neovim/nvim-lspconfig"}
	use {"glepnir/lspsaga.nvim", event = "BufRead"}
	use {"kabouzeid/nvim-lspinstall", event = "BufRead"}

	use {
		'nvim-telescope/telescope.nvim',
		requires = {
			{'nvim-lua/popup.nvim'},
			{'nvim-lua/plenary.nvim'},
		}
	}
	use 'nvim-telescope/telescope-fzy-native.nvim'
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
	}

	use 'kyazdani42/nvim-web-devicons'
	use 'kyazdani42/nvim-tree.lua'
end

return require('packer').startup(init)
