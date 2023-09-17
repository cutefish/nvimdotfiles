--------------------------------------------------------------------------------
-- Setup language servers.
--------------------------------------------------------------------------------
require('xy0.lsp.pyright').setup()

--------------------------------------------------------------------------------
-- Global mappings.
--------------------------------------------------------------------------------
local telescope_builtin = require('telescope.builtin')
-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', '<space>o', telescope_builtin.diagnostics, opts)
    vim.keymap.set('n', '<space>s', telescope_builtin.lsp_document_symbols, opts)
    vim.keymap.set('n', '<space>w', telescope_builtin.lsp_dynamic_workspace_symbols, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', telescope_builtin.lsp_definitions, opts)
    vim.keymap.set('n', 'gr', telescope_builtin.lsp_references, opts)
    vim.keymap.set('n', 'gi', telescope_builtin.lsp_implementations, opts)
    vim.keymap.set('n', 'gt', telescope_builtin.lsp_type_definitions, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    -- vim.keymap.set('n', '<space>wl', function()
    --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
