local M = {}

function M.setup()
    vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', {
        noremap = true,
        silent = true,
    })
end

function M.config()
	require("nvim-tree.events").on_nvim_tree_ready(
		function()
			vim.cmd("NvimTreeRefresh")
		end
	)
	vim.g.nvim_tree_ignore = { '.git', 'node_modules', '.cache' }
	vim.g.nvim_tree_auto_open = 0
	vim.g.nvim_tree_auto_close = 1
	vim.g.nvim_tree_follow = 1
	vim.g.nvim_tree_hide_dotfiles = 0
	vim.g.nvim_tree_indent_markers = 1
end

return M
