vim.api.nvim_create_autocmd("FileType", {
  desc = "dont list quickfix buffers",
  pattern = "qf",
  group = vim.api.nvim_create_augroup('dont-list-quickfix', { clear = true }),
  callback = function()
    vim.opt_local.buflisted = false
  end,
})

