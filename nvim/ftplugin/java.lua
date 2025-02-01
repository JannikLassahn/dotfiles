local config = require('plugins/lsp/jdtls').config
local jdtls = require 'jdtls'

jdtls.start_or_attach(config)
