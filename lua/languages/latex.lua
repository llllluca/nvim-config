vim.api.nvim_create_autocmd("FileType", {
  desc = "set makeprg, errorformat and search forward for latex file",
  pattern = "tex",
  group = vim.api.nvim_create_augroup('latex-makeprg-errorformat-searchforward', { clear = true }),
  callback = function()
    vim.opt_local.makeprg = 'tectonic -X compile -Z shell-escape --synctex %'
    vim.opt_local.errorformat = '%t%*[^:]: %f:%l: %m, %A%t%*[^:]: %f:%l: ,%Z%m'
    -- complete the \begin{...} \end{...} environment.
    -- Example: type the word `document' and then press <leader>e with the cursor under word `document'.
    vim.keymap.set('n', '<leader>e', "ciw\\begin{}<Esc>Pyypldwiend<Esc>O", { desc = "" })
    vim.keymap.set('n', 'ff',
    function()
        -- full path of the file in the current buffer
        local input = vim.fn['expand']('%:p')
        -- full path of file in the current buffer without extension
        local output = vim.fn['expand']('%:p:r')
        local line = vim.fn['line']('.')
        -- Backward search options are set in zathura config file, see ~/.config/zathura/zathurarc
        -- Use Ctr-click to use backward search inside zathura
        -- I dont know why, but if backword search stop working just rm ~/.nvim-server.pipe
        local cmd = 'zathura --synctex-forward '.. line .. ':1:' .. input .. ' ' .. output .. '.pdf'
        vim.fn['jobstart'](cmd)
    end, { desc = "synctex forward search" })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "set folding for \\begin \\end environment in latex file",
  pattern = "tex",
  group = vim.api.nvim_create_augroup('latex-folding', { clear = true }),
  callback = function()
  vim.keymap.set('n', 'zf',
    function()
      -- current line number
      local line = vim.fn.line(".")
      -- current column number
      local col = vim.fn.col(".")
      -- current line content
      local line_content = vim.fn.getline(".")
      local latex_begin = string.match(line_content, "\\begin{%w+*?}")
      if latex_begin == nil then return end
      local latex_end = string.gsub(latex_begin, "\\begin{(%w+*?)}", "\\end{%1}")

      local search = function(latex_begin, latex_end, line, col)
          local stack = {}
          -- in vim search both '*' and '\' need to be escaped
          local latex_begin = "\\" .. string.gsub(latex_begin, "*", "\\*")
          local latex_end = "\\" .. string.gsub(latex_end, "*", "\\*")

          -- set cursor at first column, 
          -- makes vim.fn.search more robust to corner case
          vim.fn.cursor(line, 1)
          repeat
              local found = vim.fn.search(
                "\\(" .. latex_begin .. "\\)\\|\\(" .. latex_end .. "\\)", "pe")
              -- 2 is latex_begin, 3 is latex_end, see flag 'p' of vim.fn.search
              if found == 2 then
                table.insert(stack, found)
              elseif found == 3 and stack[#stack] == 2 then
                  table.remove(stack)
              else
                  -- set the cursor at the original position before return, 
                  -- see flag 'e' of vim.fn.search
                  vim.fn.cursor(line, col)
                  return 0
              end
          until next(stack) == nil -- stack is empty
          -- return current line numnber, see flag 'e' of vim.fn.search
          local current_line_number = vim.fn.line(".")
          -- set the cursor at the original position before return, 
          -- see flag 'e' of vim.fn.search
          vim.fn.cursor(line, col)
          return current_line_number
      end

      local found = search( latex_begin, latex_end, line, col)
       -- print(tostring(line) .. "," .. tostring(found))
      if found ~= 0 then
        vim.cmd(tostring(line) .. "," .. tostring(found) .. "fold")
      end
    end, { desc = "synctex forward search" })
  end,
})
