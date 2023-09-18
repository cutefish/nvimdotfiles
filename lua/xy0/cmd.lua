-- Delete the buffer without losing split
vim.api.nvim_create_user_command("Bd", "b#|bd#", {})

-- Clear terminal as well as scrollback
local function clear_term()
    print('clear term')
    vim.opt_local.scrollback = 1
    vim.api.nvim_command("startinsert")
    vim.api.nvim_feedkeys("clear", 't', false)
    vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes('<cr>', true, false, true), 't', true)
    vim.opt_local.scrollback = 10000
end
vim.keymap.set('t', '<c-l><c-l>', clear_term)
