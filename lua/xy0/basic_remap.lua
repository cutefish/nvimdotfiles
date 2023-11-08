--------------------------------------------------------------------------------
-- Terminal settings
--------------------------------------------------------------------------------
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.keymap.set("n", "<leader>tv", ":execute ':vsp term://bash'<CR>a")
vim.keymap.set("n", "<leader>ts", ":execute ':sp term://bash'<CR>a")
vim.keymap.set("n", "<leader>tt", ":execute ':tabnew term://bash'<CR>a")
-- Exit terminal mode
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

--------------------------------------------------------------------------------
-- Windows navigations
--------------------------------------------------------------------------------
vim.keymap.set("t", "<c-h>", "<c-\\><c-N><c-w>h")
vim.keymap.set("t", "<c-j>", "<c-\\><c-N><c-w>j")
vim.keymap.set("t", "<c-k>", "<c-\\><c-N><c-w>k")
vim.keymap.set("t", "<c-l>", "<c-\\><c-N><c-w>l")
vim.keymap.set("i", "<c-h>", "<c-\\><c-N><c-w>h")
vim.keymap.set("i", "<c-j>", "<c-\\><c-N><c-w>j")
vim.keymap.set("i", "<c-k>", "<c-\\><c-N><c-w>k")
vim.keymap.set("i", "<c-l>", "<c-\\><c-N><c-w>l")
vim.keymap.set("n", "<c-h>", "<c-w>h")
vim.keymap.set("n", "<c-j>", "<c-w>j")
vim.keymap.set("n", "<c-k>", "<c-w>k")
vim.keymap.set("n", "<c-l>", "<c-w>l")
vim.keymap.set("t", "<a-h>", "<c-\\><c-N>:tabprev<CR>")
vim.keymap.set("t", "<a-l>", "<c-\\><c-N>:tabnext<CR>")
vim.keymap.set("n", "<a-h>", ":tabprev<CR>")
vim.keymap.set("n", "<a-l>", ":tabnext<CR>")

--------------------------------------------------------------------------------
-- Tab navigations
--------------------------------------------------------------------------------
vim.keymap.set("n", "<leader>tn", "<c-w>T<CR>")
vim.keymap.set("n", "<leader>tm", ":tabm<Space>")
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>")
vim.keymap.set("n", "<leader>to", ":tabonly<CR>")
vim.keymap.set("n", "<leader>tH", ":-tabmove<CR>")
vim.keymap.set("n", "<leader>tL", ":+tabmove<CR>")
vim.keymap.set("n", "<leader>t1", "1gt")
vim.keymap.set("n", "<leader>t2", "2gt")
vim.keymap.set("n", "<leader>t3", "3gt")
vim.keymap.set("n", "<leader>t4", "4gt")
vim.keymap.set("n", "<leader>t5", "5gt")
vim.keymap.set("n", "<leader>t6", "6gt")
vim.keymap.set("n", "<leader>t7", "7gt")
vim.keymap.set("n", "<leader>t8", "8gt")
vim.keymap.set("n", "<leader>t9", "9gt")
vim.keymap.set("n", "<leader>t0", "10gt")

--------------------------------------------------------------------------------
-- Misc
--------------------------------------------------------------------------------
-- Move visual block
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- New line in normal
vim.keymap.set("n", "<leader>r", "<Insert><cr><esc>")

-- Delete the buffer without losing split
vim.api.nvim_create_user_command("Bd", "b#|bd#", {})

-- Clear terminal as well as scrollback
local function clear_term()
    vim.opt_local.scrollback = 1
    vim.api.nvim_command("startinsert")
    vim.api.nvim_feedkeys("clear", 't', false)
    vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes('<cr>', true, false, true), 't', true)
    vim.opt_local.scrollback = 10000
end
vim.keymap.set('t', '<c-l><c-l>', clear_term)

-- Pretty-print the current line as json to a new anonymous window
local function pretty_print_json()
    local current_line = vim.api.nvim_get_current_line()
    local command = "python3 -m json.tool"
    local bufnr = vim.api.nvim_create_buf(false, true)
    local writebuf = function(channel, data, name)
        for i, line in ipairs(data) do
            vim.api.nvim_buf_set_lines(bufnr, i, i, false, { line })
        end
    end

    -- create a job to run the command
    job = vim.fn.jobstart(command, {
        stdout_buffered = true,
        stderr_buffered = true,
        on_stdout = writebuf,
        on_stderr = writebuf,
        on_exit = function(channel, code, name)
            if (code ~= 0) then
                print('Exiting with code ' .. code)
            end
        end,
    })

    vim.fn.chansend(job, current_line)
    vim.fn.chanclose(job, 'stdin')
    vim.fn.jobwait({ job }, 1000)
    vim.cmd('vsp')
    vim.api.nvim_win_set_buf(0, bufnr)
end
vim.api.nvim_create_user_command("Pj", pretty_print_json, {})
