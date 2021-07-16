local M = {}

function M.setup()
	local map = vim.api.nvim_set_keymap
	map('n', '<Leader>f', '<cmd>Telescope find_files<cr>', { noremap = true })
	map('n', '<Leader>b', '<cmd>Telescope buffers<cr>', { noremap = true })
	map('n', '<Leader>h', '<cmd>Telescope oldfiles<cr>', { noremap = true })
	map('n', '<Leader>rg', '<cmd>Telescope live_grep<cr>', { noremap = true })
	map('n', '<Leader>rw', '<cmd>Telescope grep_string<cr>', { noremap = true })
end

function M.config()
	if not packer_plugins['plenary.nvim'].loaded then
		vim.cmd [[packadd plenary.nvim]]
		vim.cmd [[packadd popup.nvim]]
		vim.cmd [[packadd telescope-fzy-native.nvim]]
	end

	local sorters = require 'telescope.sorters'
	local previewers = require 'telescope.previewers'

	require('telescope').setup {
		defaults = {
			selection_caret = " ",
			file_ignore_patterns = { "node_modules" },
			sorting_strategy = 'ascending',
			file_sorter = sorters.get_fzy_sorter,
			generic_sorter = sorters.get_fzy_sorter,
			file_previewer = previewers.vim_buffer_cat.new,
			grep_previewer = previewers.vim_buffer_vimgrep.new,
			qflist_previewer = previewers.vim_buffer_qflist.new,
		},
		extensions = {
			fzy_native = {
				override_generic_sorter = false,
				override_file_sorter = true,
			}
		}
	}

	require('telescope').load_extension('fzy_native')
end

return M
