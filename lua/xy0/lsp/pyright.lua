local M = {}
local util = require("xy0.lsp.util")
local lspconfig = require('lspconfig')
function M.setup()
  lspconfig.pyright.setup({
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_dir = util.get_root,
  })
end
return M
