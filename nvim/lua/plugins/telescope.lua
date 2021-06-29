require('telescope').setup {
	extensions = {
		fzy_native = {
			override_generic_sorter = false,
			override_file_sorter = true
		}
	}
}

require("telescope").load_extension("fzy_native")

local map = vim.api.nvim_set_keymap
map('n', '<Leader>f', '<cmd>Telescope find_files<cr>', { noremap = true })
map('n', '<Leader>b', '<cmd>Telescope buffers<cr>', { noremap = true })
map('n', '<Leader>h', '<cmd>Telescope oldfiles<cr>', { noremap = true })
map('n', '<Leader>rg', '<cmd>Telescope live_grep<cr>', { noremap = true })
map('n', '<Leader>rw', '<cmd>Telescope grep_string<cr>', { noremap = true })
