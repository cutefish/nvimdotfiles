local util = require('xy0.util')

-- opening directory
util.set_opening_directory()

-- leader key
vim.g.mapleader = ","

-- line number
vim.wo.number = true
vim.wo.relativenumber = true

--- It seems for terminal buffers, we need to override the default setting again.
--- Create an autocommand group to organize our terminal settings
local term_group = vim.api.nvim_create_augroup('MyTermSettings', { clear = true })

--- Create the autocommand
vim.api.nvim_create_autocmd('TermOpen', {
  group = term_group,
  pattern = '*',
  callback = function()
    -- Set options locally for the terminal buffer window
    vim.wo.number = true
    vim.wo.relativenumber = true
  end,
})

-- clipboard
vim.opt.clipboard = "unnamedplus"

-- tab settings
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- search
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- term colors
vim.opt.termguicolors = true

-- blink cursor
vim.opt.guicursor = "a:blinkwait1-blinkon100"

-- disable mouse
vim.opt.mouse = ""

-- smart indent
vim.opt.smartindent = true

-- enable lsp logging for debugging
-- vim.lsp.set_log_level('debug')

if os.getenv('WSL_DISTRO_NAME') ~= nil then -- Check if running in WSL
  vim.g.clipboard = {
    name = 'wsl clipboard',
    copy = {
      ['+'] = { 'clip.exe' },
      ['*'] = { 'clip.exe' }
    },
    paste = {
      ['+'] = { 'powershell.exe', '-c', '[Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))' },
      ['*'] = { 'powershell.exe', '-c', '[Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))' }
    },
    cache_enabled = true
  }
end
