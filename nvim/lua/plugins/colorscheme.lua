return {
  { 'rebelot/kanagawa.nvim' },
  { 'folke/tokyonight.nvim' },
  { 'xiantang/darcula-dark.nvim' },
  { 'rose-pine/neovim' },
  {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_background = 'hard'
      vim.g.gruvbox_material_foreground = 'material'
      vim.g.gruvbox_material_enable_italic = true
      vim.cmd.colorscheme 'gruvbox-material'
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
