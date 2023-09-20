-- register lsp status
local lspstatus = require('lsp-status')
lspstatus.register_progress()
lspstatus.config {
    current_function = true,
    -- hint looks like warning, just use 'H'
    indicator_hint = 'H',
}

-- setup language servers.
require('xy0.lsp.pyright').setup()
require('xy0.lsp.bashls').setup()
require('xy0.lsp.luals').setup()
require('xy0.lsp.jdtls').setup()

local util = require('xy0.lsp.util')
--------------------------------------------------------------------------------
-- Global mappings.
--------------------------------------------------------------------------------
-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        util.on_attach(ev.buf)
    end,
})
