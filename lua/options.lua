-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
-- vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
--[[
Example of how Breakindent works: a tab followed by a very 
long sentence that is longer than the width of the window
  print("very very long message")
  will breaks as:
  print("very very long 
  message")
  and not:
  print("very very long 
message")
--]]
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'number'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
-- vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
-- splitting a window will put 
-- the new window below (right) the current one,
-- the cursor go on the new window.
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

--- Use the appropriate number of spaces to insert a <Tab>
vim.opt.expandtab = true

--Number of spaces to use for each step of (auto)indent.  Used for >>, <<, etc.
vim.opt.shiftwidth = 4

-- Number of spaces that a <Tab> in the file counts for
vim.opt.tabstop = 4

-- when opening a new line automatically insert the same amount of tabs of the previuos line
vim.opt.smartindent = true

vim.opt.shell="/bin/bash"
vim.opt.shellpipe="&>"



