local M = {}
local util = require("xy0.util")
local lspconfig = require('lspconfig')
local cmp = require('cmp_nvim_lsp')
function M.setup()
  lspconfig.lua_ls.setup({
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_dir = util.get_root,
    single_file_support = true,
    capabilities = cmp.default_capabilities(),
  })
end
return M
