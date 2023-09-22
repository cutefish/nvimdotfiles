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
    'n', '<leader>F',
    function() builtin.find_files({ no_ignore = true }) end, {})
vim.keymap.set('n', '<leader>fp', builtin.resume, {})
vim.keymap.set('n', '<leader>fm', builtin.man_pages, {})
vim.keymap.set('n', '<leader>f/', builtin.search_history, {})

telescope.setup {
    defaults = {
        path_display = { "smart" },
        mappings = {
            i = {
                ["<c-s>"] = actions.select_all,
            },
        },
    }
}
