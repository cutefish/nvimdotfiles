local M = {}
local cmp = require('cmp_nvim_lsp')
local lspstatus = require('lsp-status')
local telescope_builtin = require('telescope.builtin')
function M.on_attach(bufnr)
    -- auto completion
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
    -- key mappings.
    local function buf_set_keymap(mode, lhs, rhs, opts)
        opts.buffer = bufnr
        vim.keymap.set(mode, lhs, rhs, opts)
    end
    local opts = { noremap=true, silent=true }
    buf_set_keymap(
        'n', '<space>a', telescope_builtin.diagnostics, opts)
    buf_set_keymap(
        'n', '<space>o', telescope_builtin.lsp_document_symbols, opts)
    buf_set_keymap(
        'n', '<space>s', telescope_builtin.lsp_dynamic_workspace_symbols, opts)
    buf_set_keymap(
        'n', '<space>rn', vim.lsp.buf.rename, opts)
    buf_set_keymap('n', 'gD', vim.lsp.buf.declaration, opts)
    buf_set_keymap('n', 'gd', telescope_builtin.lsp_definitions, opts)
    buf_set_keymap('n', 'gr', telescope_builtin.lsp_references, opts)
    buf_set_keymap('n', 'gi', telescope_builtin.lsp_implementations, opts)
    buf_set_keymap('n', 'gt', telescope_builtin.lsp_type_definitions, opts)
    buf_set_keymap('n', 'K', vim.lsp.buf.hover, opts)
    buf_set_keymap('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    -- vim.keymap.set('n', '<space>wl', function()
    --     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    --     end, opts)
    buf_set_keymap(
        { 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    buf_set_keymap(
        { 'n', 'v' }, '<space>f',
        function() vim.lsp.buf.format { async = true } end, opts)
end

function M.get_capabilities()
    return vim.tbl_extend(
        'keep', cmp.default_capabilities() or {},
        lspstatus.capabilities)
end
return M
