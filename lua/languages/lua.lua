-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lua_ls
local lspconfig = require('lspconfig')
lspconfig.lua_ls.setup {
    cmd = { vim.fn.stdpath('config') .. '/thirdparty/lua-language-server-3.14.0/bin/lua-language-server' },
    settings = {
        Lua = {
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
        }
    }
  }

