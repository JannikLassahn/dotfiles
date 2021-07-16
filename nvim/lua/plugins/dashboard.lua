local M = {}

function M.config()
	local home = os.getenv('HOME')

	vim.g.dashboard_default_executive = 'telescope'
	vim.g.dashboard_custom_section = {
		last_session = {
			description = {'  Recently laset session                  SPC s l'},
			command =  'SessionLoad'},
			find_history = {
			description = {'  Recently opened files                   SPC f h'},
			command =  'DashboardFindHistory'
		},
		find_file  = {
			description = {'  Find  File                              SPC f f'},
			command = 'Telescope find_files find_command=rg,--hidden,--files'
		},
		new_file = {
			description = {'  File Browser                            SPC f b'},
			command =  'Telescope file_browser'
		},
		find_word = {
			description = {'  Find  word                              SPC f w'},
			command = 'DashboardFindWord'
		},
		find_dotfiles = {
			description = {'  Open Personal dotfiles                  SPC f d'},
			command = 'Telescope dotfiles path=' .. home ..'/.dotfiles'
		},
	}

end

return M
