local M = {}
local util = require("xy0.util")
local lspconfig = require('lspconfig')
local cmp = require('cmp_nvim_lsp')
function M.setup()
    lspconfig.bashls.setup({
        cmd = { 'bash-language-server', 'start' },
        settings = {
            bashIde = {
                -- Glob pattern for finding and parsing shell script files in the workspace.
                -- Used by the background analysis features across files.

                -- Prevent recursive scanning which will cause issues when opening a file
                -- directly in the home directory (e.g. ~/foo.sh).
                --
                -- Default upstream pattern is "**/*@(.sh|.inc|.bash|.command)".
                globPattern = vim.env.GLOB_PATTERN or '*@(.sh|.inc|.bash|.command)',
            },
        },
        filetypes = { 'sh' },
        root_dir = util.get_root,
        single_file_support = true,
        capabilities = cmp.default_capabilities(),
    })
end
return M
