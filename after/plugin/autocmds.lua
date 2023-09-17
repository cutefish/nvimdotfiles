vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "*.java", "*.py" },
  callback = function() vim.opt.colorcolumn = "80"  end,
})
