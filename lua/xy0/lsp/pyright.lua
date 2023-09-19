local M = {}
local util = require("xy0.util")
local lsputil = require("xy0.lsp.util")
local lspconfig = require('lspconfig')
local lspstatus = require('lsp-status')
function M.setup()
  lspconfig.pyright.setup({
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_dir = util.get_root,
    on_attach = function() lspstatus.on_attach() end,
    capabilities = lsputil.get_capabilities(),
  })
end
return M
