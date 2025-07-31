vim.api.nvim_create_autocmd("FileType", {
    desc = "set makeprg for markdown file",
    -- use `:set filetype?` to see the detected filetype of the current file
    pattern = "markdown",
    group = vim.api.nvim_create_augroup('markdown-makeprg-format', { clear = true }),
    callback = function()
        -- full path of file in the current buffer
        vim.opt_local.makeprg = 'md %'

        vim.keymap.set('n', 'ff',
        function()
            -- full path of file in the current buffer
            local md_filepath = vim.fn.expand('%:p')
            local html_filepath = vim.fs.dirname(md_filepath) .. '/.' .. vim.fs.basename(md_filepath) .. '.html'
            local cmd = 'firefox --new-window ' .. html_filepath
            vim.fn.jobstart(cmd)
        end, { desc = "start firefox with the converted markdown file" })

        -- vim.keymap.set('v', '<leader>f', ':\'<,\'>!fmt --width=80 <cr>', { desc = "format text" })
    end,
    })

