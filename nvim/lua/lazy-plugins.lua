-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
require('lazy').setup {
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  'mfussenegger/nvim-jdtls', -- Java LSP

  require 'plugins/gitsigns',

  require 'plugins/which-key',

  require 'plugins/telescope',

  require 'plugins/lsp',

  require 'plugins/conform',

  require 'plugins/cmp',

  require 'plugins/tokyonight',

  require 'plugins/todo-comments',

  require 'plugins/mini',

  require 'plugins/treesitter',

  -- require 'plugins.debug',
  -- require 'plugins.indent_line',
  -- require 'plugins.lint',
  -- require 'plugins.autopairs',
  require 'plugins.neo-tree',
}
