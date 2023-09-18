-- opening directory
vim.g.xy0openingDirectory = vim.loop.cwd()

-- leader key
vim.g.mapleader = ","

-- line number
vim.wo.number = true
vim.wo.relativenumber = true

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
vim.opt.guicursor="a:blinkwait1-blinkon100"
