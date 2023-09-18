local M = {}
local util = require("xy0.util")
local lspconfig = require('lspconfig')
function M.setup()
  lspconfig.lua_ls.setup({
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_dir = util.get_root,
    single_file_support = true,
  })
end
return M
