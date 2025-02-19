vim.filetype.add {
  pattern = {
    -- overwrite the filetype for Angular component templates
    -- NOTE: remove with nvim 0.11
    ['.*%.component%.html'] = 'htmlangular',
  },
}
