local M = {}
local lspconfig = require('lspconfig')
function M.get_root(filename, bufnr)
  local root_files = {
    'README.md',
    '.git',
    'pom.xml',
  }
  local primary = lspconfig.util.root_pattern(unpack(root_files))(fname)
  local root = primary or vim.g.xy0openingDirectory
  print('lspconfig using root' .. root)
  return root
end
return M
