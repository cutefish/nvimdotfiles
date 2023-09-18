local M = {}
local lspconfig = require('lspconfig')
function M.get_root(filename, bufnr)
    local root_files = {
        'README.md',
        '.git',
        'pom.xml',
    }
    table.unpack = table.unpack or unpack
    local primary = lspconfig.util.root_pattern(
        table.unpack(root_files))(filename)
    local root = primary or vim.g.xy0openingDirectory
    return root
end

function M.get_project_name()
    return vim.fn.fnamemodify(vim.g.xy0openingDirectory, ':p:h:t')
end

return M
