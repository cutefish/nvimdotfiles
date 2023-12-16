local telescope = require('telescope')
local actions = require('telescope.actions')
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set(
    'n', '<leader>fG',
    function() builtin.grep_string({ search = vim.fn.input('Grep: ') }) end,
    {})
vim.keymap.set('n', '<leader>fw', builtin.grep_string, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fc', builtin.git_commits, {})
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set(
    'n', '<leader>fF',
    function()
        builtin.find_files({
            no_ignore = true,
            no_ignore_parent = true,
            follow = true,
            hidden = true })
    end, {})
vim.keymap.set('n', '<leader>fp', builtin.resume, {})
vim.keymap.set('n', '<leader>fm', builtin.man_pages, {})
vim.keymap.set('n', '<leader>f/', builtin.search_history, {})

telescope.setup {
    defaults = {
        path_display = function(_, path)
            local utils = require('telescope.utils')
            local bufname_tail = utils.path_tail(path)
            local path_without_tail = require('plenary.strings').truncate(path, #path - #bufname_tail, '')
            local path_to_display = utils.transform_path({
                path_display = { 'truncate' },
            }, path_without_tail)
            return string.format("%s (%s)", bufname_tail, path_to_display)
        end,
        mappings = {
            i = {
                ["<c-s>"] = actions.select_all,
            },
        },
    }
}
