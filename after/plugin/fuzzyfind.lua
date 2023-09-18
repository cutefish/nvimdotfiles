local telescope = require('telescope')
local actions = require('telescope.actions')
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.keymap.set('n', '<leader>A', builtin.live_grep, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set('n', '<leader>c', builtin.git_commits, {})
vim.keymap.set('n', '<leader>g', builtin.git_files, {})
vim.keymap.set('n', '<leader>p', builtin.resume, {})
vim.keymap.set('n', '<leader>m', builtin.man_pages, {})
vim.keymap.set('n', '<leader>/', builtin.search_history, {})

telescope.setup {
  defaults = {
    mappings = {
      i = {
        ["<c-s>"] = actions.select_all,
      },
    },
  }
}
