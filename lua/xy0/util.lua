local M = {}
local config = require('xy0.config')

function M.set_opening_directory()
    if not vim.g.xy0OpeningDirectory then
        vim.g.xy0OpeningDirectory = vim.fn.getcwd()
        if vim.g.xy0OpeningDirectory ~= nil then
            print("Opening directory is " .. M.get_opening_directory())
        end
    end
end

function M.get_opening_directory()
    return vim.g.xy0OpeningDirectory
end

function M.get_root(bufname)
    bufname = bufname or
    vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
    local patterns = config.root_patterns
    local dirname = vim.fn.fnamemodify(bufname, ':p:h')
    local getparent = function(p)
        return vim.fn.fnamemodify(p, ':h')
    end
    while getparent(dirname) ~= dirname do
        for _, pattern in ipairs(patterns) do
            if vim.loop.fs_stat(dirname .. '/' .. pattern) then
                return dirname
            end
        end
        dirname = getparent(dirname)
    end
    return M.get_opening_directory()
end

function M.get_project_name()
    return vim.fn.fnamemodify(M.get_root(), ':p:h:t')
end

return M
