local M = {}
local util = require("xy0.util")
local lspconfig = require('lspconfig')
local cmp = require('cmp_nvim_lsp')
function M.setup()
  lspconfig.pyright.setup({
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_dir = util.get_root,
    capabilities = cmp.default_capabilities(),
  })
end
return M
