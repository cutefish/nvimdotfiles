--------------------------------------------------------------------------------
-- Fugitive
--------------------------------------------------------------------------------
vim.api.nvim_create_user_command("Gl", "Git log", {})
vim.api.nvim_create_user_command("Gst", "Git status", {})
vim.api.nvim_create_user_command("Gd", "Git diff", {})
vim.api.nvim_create_user_command("Gb", "Git blame", {})
vim.api.nvim_create_user_command("Gup", function(opts)
    vim.cmd("Git add . ")
    vim.cmd('Git ci -m ' .. (opts.args or "update"))
    vim.cmd('Git push')
end, { nargs="?" })

--------------------------------------------------------------------------------
-- Diffview
--------------------------------------------------------------------------------
vim.api.nvim_create_user_command("Dv", function(opts)
    vim.cmd("DiffviewOpen " .. (opts.args or ""))
end, { nargs="?" })
