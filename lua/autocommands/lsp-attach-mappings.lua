vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
    callback = function(event)

        local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        -- Rename the variable under your cursor.
        --  Most Language Servers support renaming across files, etc.
        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

        -- Opens a popup that displays documentation about the word under your cursor
        --  See `:help K` for why this keymap.
        map('K', vim.lsp.buf.hover, 'Hover Documentation')

        -- WARN: This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header and 
        --  in Java this would take you to the import statement.
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        map('gd',vim.lsp.buf.definition, '[G]oto [d]efinition')

        -- Lists all the implementations for the symbol under the cursor in the
        -- quickfix window.
        map('li',vim.lsp.buf.implementation, '[l]ist [i]mplementation')

        -- Lists all the references to the symbol under the cursor in the quickfix window.
        map('lr', vim.lsp.buf.references, '[l]ist [r]eference')

        -- <leader>d è gia mappato
        -- map('<space>d', vim.lsp.buf.type_definition, "Go to type definition")

        map('<space>wa', vim.lsp.buf.add_workspace_folder, "Add workspace folder")
        map('<space>wr', vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
        map('<space>wl',
            function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, "List workspace folders")
        end,
})
