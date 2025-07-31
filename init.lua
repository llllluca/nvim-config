-- See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--  To check the current status of your plugins, run :Lazy
--  You can press `?` in this menu for help. Use `:q` to close the window
--  To update plugins you can run :Lazy update
require('lazy').setup({
    "mfussenegger/nvim-jdtls",
    "neovim/nvim-lspconfig",
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function ()
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                -- A list of parser names, or "all" 
                -- (the listed parsers MUST always be installed)
                -- Uninstall a parser: :TSUninstall scala
                ensure_installed = {
                    "c",
                    "cpp",
                    "lua",
                    "vim",
                    "vimdoc",
                    "java",
                    "markdown",
                    "go",
                    "rust",
                    "haskell",
                },
                -- Install parsers synchronously 
                -- (only applied to `ensure_installed`)
                sync_install = false,
                highlight = { enable = true },
                -- Indentation based on treesitter for the = operator.
                indent = { enable = true }
            })
        end
    },
})

require 'options'
require 'mappings'
require 'autocommands.diagnostic-from-quickfix'
require 'autocommands.dont-list-quickfix-buffers'
require 'autocommands.highlight-when-yanking'
require 'autocommands.set-makeprg-from-cache'
require 'autocommands.lsp-attach-mappings'
require 'languages.c'
require 'languages.rust'
require 'languages.latex'
require 'languages.java'
require 'languages.scala'
require 'languages.lua'
require 'languages.markdown'
require 'gruber'
require 'diagnostics-config'

