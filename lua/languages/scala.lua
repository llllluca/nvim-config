vim.api.nvim_create_autocmd("FileType", {
  desc = "'set makeprg and errorformat for java file",
  pattern = "scala",
  group = vim.api.nvim_create_augroup('scala-errorformat', { clear = true }),
  callback = function()
    vim.opt_local.errorformat = '%f:%l: %t%*[^:]: %m'
    vim.opt_local.makeprg = 'scalac %'
  end,
})

