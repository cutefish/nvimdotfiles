local M = {}
local util = require("xy0.util")
local lsputil = require("xy0.lsp.util")
local lspconfig = require('lspconfig')
local lspstatus = require('lsp-status')
function M.setup()
  lspconfig.lua_ls.setup({
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_dir = util.get_root,
    single_file_support = true,
    on_attach = function() lspstatus.on_attach() end,
    capabilities = lsputil.get_capabilities(),
  })
end
return M
