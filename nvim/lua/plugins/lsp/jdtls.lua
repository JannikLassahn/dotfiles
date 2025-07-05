-- JDTLS (Java LSP) configuration

local function get_shared_pkg(pkg_name)
  return vim.fn.expand('$MASON/share/' .. pkg_name)
end

local function join(...)
  return table.concat({ ... }, '/')
end

local root_markers = { 'mvnw', 'pom.xml', '.git' }
local root_dir = vim.fs.root(0, root_markers)
if not root_dir then
  return
end

local jdtls = require 'jdtls'
local home_dir = os.getenv 'HOME'
local jdtls_pkg_dir = get_shared_pkg 'jdtls'

local lombok_path = join(jdtls_pkg_dir, 'lombok.jar')
local equinox_path = join(jdtls_pkg_dir, 'plugins', 'org.eclipse.equinox.launcher.jar')

local nvim_cache_dir = vim.fn.stdpath 'cache'
local jdtls_config_dir = join(jdtls_pkg_dir, 'config')

local project_name = vim.fn.fnamemodify(root_dir, ':p:h:t')
local workspace = join(nvim_cache_dir, 'jdtls', 'workspaces', project_name)

local capabilities = require('blink.cmp').get_lsp_capabilities()

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx4g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',

    '-javaagent:' .. lombok_path,

    '-jar',
    equinox_path,

    '-configuration',
    jdtls_config_dir,

    '-data',
    workspace,
  },

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  settings = {
    java = {
      home = home_dir .. '/.sdkman/candidates/java/21.0.2-open',
      configuration = {
        runtimes = {
          {
            name = 'JavaSE-21',
            path = home_dir .. '/.sdkman/candidates/java/21.0.2-open',
          },
          {
            name = 'JavaSE-23',
            path = home_dir .. '/.sdkman/candidates/java/23.0.1-open',
          },
        },
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      signatureHelp = { enabled = true },
      format = {
        enabled = true,
        settings = {
          url = 'https://github.com/google/styleguide/blob/gh-pages/intellij-java-google-style.xml',
          profile = 'GoogleStyle',
        },
      },
    },
    completion = {
      favoriteStaticMembers = {
        'org.hamcrest.MatcherAssert.assertThat',
        'org.hamcrest.Matchers.*',
        'org.hamcrest.CoreMatchers.*',
        'org.junit.jupiter.api.Assertions.*',
        'java.util.Objects.requireNonNull',
        'java.util.Objects.requireNonNullElse',
        'org.mockito.Mockito.*',
      },
    },
    extendedClientCapabilities = jdtls.extendedClientCapabilities,
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    codeGeneration = {
      useBlocks = true,
    },
  },
  capabilities = capabilities,
  flags = {
    allow_incremental_sync = true,
  },
  init_options = {},
  handlers = {},
}

-- mute; having progress reports is enough
config.handlers['language/status'] = function() end

-- bundles for running tests
local plug_jar_map = {
  ['java-test'] = {
    'junit-jupiter-*.jar',
    'junit-platform-*.jar',
    'junit-vintage-engine_*.jar',
    'org.apiguardian.api_*.jar',
    'org.eclipse.jdt.junit4.runtime_*.jar',
    'org.eclipse.jdt.junit5.runtime_*.jar',
    'org.opentest4j_*.jar',
    'org.jacoco.*.jar',
    'com.microsoft.java.test.plugin-*.jar',
  },
  ['java-debug-adapter'] = {
    'com.microsoft.java.debug.plugin-*.jar',
  },
}

local bundles = {}

for plugin, jar_patterns in pairs(plug_jar_map) do
  local root = get_shared_pkg(plugin)
  for _, jar in ipairs(jar_patterns) do
    for _, bundle in ipairs(vim.split(vim.fn.glob(join(root, jar)), '\n')) do
      table.insert(bundles, bundle)
    end
  end
end

config.init_options['bundles'] = bundles

-- Needed for debugging
config['on_attach'] = function(client, bufnr)
  local function compile()
    if vim.bo.modified then
      vim.cmd 'w'
    end
    client.request_sync('java/buildWorkspace', false, 5000, bufnr)
  end
  local function with_compile(fn)
    return function()
      compile()
      fn()
    end
  end
  local map = function(keys, func, desc, mode)
    mode = mode or 'n'
    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
  end

  map('<leader>tc', with_compile(require('jdtls.dap').test_class), '[T]est [C]lass')
  map('<leader>tm', with_compile(require('jdtls.dap').test_nearest_method), '[T]est nearest [M]ethod')
  map('<leader>ts', with_compile(require('jdtls.dap').pick_test), '[T]est [S]elected')

  jdtls.setup_dap { hotcodereplace = 'auto' }
  require('jdtls.dap').setup_dap_main_class_configs()
end

return { config = config }
