local M = {}
local util = require("xy0.lsp.util")
local install_dir = '/scratch/install/jdtls/'
local config_dir = install_dir .. 'config_linux'
local workspace_dir = '/scratch/data/jdtls/ws/' .. util.get_project_name()

-- See `:help vim.lsp.start_client` for an overview of the supported `config`
-- options.
local config = {
  -- The command that starts the language server
  -- See:
  -- https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {

    'java',

    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

    '-jar',
    vim.fn.glob(
        install_dir .. "/plugins/org.eclipse.equinox.launcher_*.jar", true),

    '-configuration', config_dir,

    '-data', workspace_dir
  },

  -- 💀
  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  root_dir = util.get_root(),

  -- Here you can configure eclipse.jdt.ls specific settings
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options
    settings = {
    java = {
    }
  },

  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = {}
  },
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
function M.setup()
    vim.api.nvim_create_autocmd("Filetype", {
        pattern = "java", -- autocmd to start jdtls
        callback = function()
            require("jdtls").start_or_attach(config)
        end,
    })
end
return M
