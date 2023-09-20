--------------------------------------------------------------------------------
-- Fugitive
--------------------------------------------------------------------------------
local function use_default_if_empty(s, d)
    if s == nil or s == '' then
        return d
    else
        return s
    end
end
vim.api.nvim_create_user_command("Gl", "Git log", {})
vim.api.nvim_create_user_command("Gs", "Git status", {})
vim.api.nvim_create_user_command("Ga", "Git add .", {})
vim.api.nvim_create_user_command("Gd", "Git diff", {})
vim.api.nvim_create_user_command("GD", "Git dc", {})
vim.api.nvim_create_user_command("Gdm", "Git dm", {})
vim.api.nvim_create_user_command("Gdc", "Git diff HEAD~1", {})
vim.api.nvim_create_user_command("Gsm", "Git stm", {})
vim.api.nvim_create_user_command("Gb", "Git blame", {})
vim.api.nvim_create_user_command("Gup", function(opts)
    vim.cmd("Git add . ")
    vim.cmd('Git ci -m ' .. (use_default_if_empty(opts.args, "update")))
    vim.cmd('Git push')
end, { nargs="?" })
vim.api.nvim_create_user_command("Gv", function(opts)
    vim.cmd("Gvdiffsplit " .. opts.args)
end, { nargs="?" })

--------------------------------------------------------------------------------
-- Diffview
--------------------------------------------------------------------------------
vim.api.nvim_create_user_command("Dv", function(opts)
    vim.cmd("DiffviewOpen " .. (opts.args or ""))
end, { nargs="?" })
