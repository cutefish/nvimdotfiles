--------------------------------------------------------------------------------
-- Lualine set up
--------------------------------------------------------------------------------
local lspstatus = require('lsp-status')
local config = {
    spinner_frames = {
        '|', '\\', '-', '/', '|', '\\', '-', '/', '-',
    },
    max_filename_len = 40,
    max_filename_win_percentage = 0.4,
    component_separators = '|'
}
local function get_lsp_message()
    local buf_messages = lspstatus.messages()
    local msgs = {}

    for _, msg in ipairs(buf_messages) do
        local name = msg.name
        local client_name = '[' .. name .. ']'
        local contents
        if msg.progress then
            contents = msg.title
            if msg.message then contents = contents .. ' ' .. msg.message end
            -- this percentage format string escapes a percent sign
            -- once to show a percentage and one more
            -- time to prevent errors in vim statusline's
            -- because of it's treatment of % chars
            if msg.percentage then
                contents = contents ..
                    string.format(" (%.0f%%)", msg.percentage)
            end

            if msg.spinner then
                contents =
                config.spinner_frames[
                (msg.spinner % #config.spinner_frames) + 1] ..
                ' ' .. contents
            end
        elseif msg.status then
            contents = msg.content
            local filename = vim.uri_to_fname(msg.uri)
            filename = vim.fn.fnamemodify(filename, ':~:.')
            local space =
            math.min(config.max_filename_len,
            math.floor(config.max_filename_win_percentage
            * vim.fn.winwidth(0)))
            if #filename > space then
                filename = vim.fn.pathshorten(filename)
            end
            contents = '(' .. filename .. ') ' .. contents
        else
            contents = msg.content
        end
        table.insert(msgs, client_name .. ' ' .. contents)
    end
    local msg = table.concat(msgs, config.component_separator)
    msg = string.gsub(msg, '%%', '%%%%')
    return msg
end
local function safe_get_lsp_message()
    local status, ret = pcall(get_lsp_message)
    if status then
        return ret
    else
        return 'Error get_lsp_message: ' .. ret
    end
end
require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'moonfly',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'filename', 'branch', 'diff' },
        lualine_c = {
            'diagnostics',
            safe_get_lsp_message,
        },
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}
