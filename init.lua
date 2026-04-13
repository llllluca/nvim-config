-- [[ Setting options ]] --
-- See `:help vim.opt`
--  For more options, you can see `:help option-list`

vim.cmd("colorscheme gruber")

require('vim._core.ui2').enable()

-- Set <space> as the leader key
-- See `:help mapleader`
vim.g.mapleader = ' '
-- Print the line number in front of each line
vim.opt.number = true
-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = 'unnamedplus'
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
vim.opt.undofile = true
-- Save undo history to a file
vim.opt.breakindent = true
-- Case-insensitive searching uless one or
-- more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- Display signs in the 'number' column
vim.opt.signcolumn = 'number'
--splitting a window with :vsplit will put the new window right of the current one
vim.opt.splitright = true
-- splitting a window with :split will put the new window below the current one
vim.opt.splitbelow = true
-- Sets how neovim will display whitespace characters
vim.opt.list = true
-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'
-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10
-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
--Number of spaces to use for each step of (auto)indent.  Used for >>, <<, etc.
vim.opt.shiftwidth = 4
-- Number of spaces that a <Tab> in the file counts for
vim.opt.tabstop = 4
-- when opening a new line automatically insert the same amount of tabs of the previuos line
vim.opt.smartindent = true
-- Name of the shell to use for ! and :! commands
vim.opt.shell="/bin/bash"
-- String to be used to put the output of the ":make" command in the error file
vim.opt.shellpipe="&>"

-- [[ Autocommand ]] --

vim.api.nvim_create_autocmd({ "QuickFixCmdPost", "BufEnter" }, {
    desc = "Set diagnostics from errors in the quickfix buffer",
    callback = function(args)
        local qflist = vim.fn.getqflist()
        local filtered_qflist = {}
        for i, l in ipairs(qflist) do
            if l.type == 'w' then
                l.type = 'WARN'
                table.insert(filtered_qflist, qflist[i])
            elseif l.type == 'i' then
                l.type = 'INFO'
                table.insert(filtered_qflist, qflist[i])
            else
                l.type = 'ERROR'
                table.insert(filtered_qflist, qflist[i])
            end
        end
        local diagnostics = vim.diagnostic.fromqflist(filtered_qflist)
        -- Creates a new namespace or gets an existing one
        local namespace = vim.api.nvim_create_namespace("qflist")
        local bufferDiagnostics = {}
        for _, d in ipairs(diagnostics) do
            if bufferDiagnostics[d.bufnr] == nil then
                bufferDiagnostics[d.bufnr] = {}
            end
            table.insert(bufferDiagnostics[d.bufnr], d)
        end
        -- Remove all diagnostics for all buffers from the given namespace
        vim.diagnostic.reset(namespace)
        for bufnr, d in pairs(bufferDiagnostics) do
            vim.diagnostic.set(namespace, bufnr, d)
        end
    end
})

vim.api.nvim_create_autocmd( 'FileType', {
    -- ':set filetype?' to see the filetype of the current buffer
    pattern = { 'c', 'cpp', 'lua', 'markdown', 'vim' },
    callback = function()
        -- Highlight the current buffer with language taken from the current
        -- buffer file type. Parsers are searched for as parser/{lang}.so in
        -- any 'runtimepath' directory. ':set runtimepath?' to see the list
        -- of directories to be searched for the runtime files.
        -- c, lua, markdown and vimscript parser are shipped with neovim
        -- (see /lib/nvim/parser/), additional parser can be install in
        -- ~/.config/nvim/parser/
        vim.treesitter.start()

    end
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "dont list quickfix buffers",
  pattern = "qf",
  callback = function()
    vim.opt_local.buflisted = false
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(event)

        local map = function(keys, func)
            vim.keymap.set('n', keys, func, { buffer = event.buf })
        end

        -- Rename the variable under your cursor.
        --  Most Language Servers support renaming across files, etc.
        map('<leader>rn', vim.lsp.buf.rename)

        -- Execute a code action, usually your cursor needs to be
        -- on top of an error or a suggestion from your LSP for
        -- this to activate.
        map('<leader>ca', vim.lsp.buf.code_action)

        -- Opens a popup that displays documentation
        -- about the word under your cursor
        map('K', vim.lsp.buf.hover)

        --  In C go to declaration would take you to the header and
        --  in Java it would take you to the import statement.
        map('gD', vim.lsp.buf.declaration)
        map('gd',vim.lsp.buf.definition)

        -- Lists all the implementations for the symbol
        -- under the cursor in the quickfix window.
        map('li',vim.lsp.buf.implementation)

        -- Lists all the references to the symbol
        -- under the cursor in the quickfix window.
        map('lr', vim.lsp.buf.references)
    end
})

vim.api.nvim_create_autocmd("FileType", {
    desc = "Synctex search forward and backward for latex file",
    pattern = "tex",
    callback = function()
        local get_pdf_file_path = function()
            return vim.fn.input({
                prompt = "Enter pdf file path: ",
                default = "",
                completion = "file",
            })
        end
        vim.keymap.set('n', 'fp',
        function()
            vim.g.pdf_file_path = get_pdf_file_path()
        end)
        vim.keymap.set('n', 'ff',
        function()
            if not vim.g.pdf_file_path then
                vim.g.pdf_file_path = get_pdf_file_path()
            end
            -- full path of the file in the current buffer
            local tex_file = vim.fn.expand('%:p')
            local line = vim.fn.line('.')
            local backsearch_cmd = "nvim --server " .. vim.v.servername .. " --remote-send <Esc>:e\\ %{input}<CR>:%{line}<CR>"
            local cmd = 'zathura --synctex-editor-command \"' .. backsearch_cmd ..'\" --synctex-forward ' .. line ..':1:'.. tex_file ..' '.. vim.g.pdf_file_path
            vim.fn.jobstart(cmd)
        end)
    end,
})

-- [[ netrw File Explorer ]] --

vim.keymap.set('n', '<leader>e',
    function()
        for _, win in ipairs(vim.api.nvim_list_wins()) do
            local buf = vim.api.nvim_win_get_buf(win)
            if vim.bo[buf].filetype == "netrw" then
                return
            end
        end
        vim.cmd("botright 15split")
        vim.cmd("Explore")
    end)
-- suppress the netwr banner
vim.g.netrw_banner = 0
-- set tree style listing
vim.g.netrw_liststyle = 3
-- When browsing, <CR> will open the file in the previous window
vim.g.netrw_browse_split = 4
-- Highlight marked files in the same way search matches are
vim.cmd("hi! link netrwMarkFile Search")

-- [[ Diagnostic ]] --

local diagnostic_config = {
    underline = false,
    -- Higher severities are displayed before lower severities
    -- (e.g. ERROR is displayed before WARN).
    severity_sort = true,
    float = {
        --cursor can go in the floating window
        focusable = false,
        -- String to use as the header for the floating window.
        header = "",
        -- Prefix each diagnostic in the floating window.
        prefix = "",
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN]  = "",
            [vim.diagnostic.severity.HINT]  = "",
            [vim.diagnostic.severity.INFO]  = "",
        }
    },
}
vim.diagnostic.config(diagnostic_config)

-- [[ Mappings ]] --

vim.keymap.set('n', '<leader>d', vim.diagnostic.setloclist)

-- Exit terminal mode with <Esc><Esc>
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>')

-- Use CTRL+<hjkl> to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>')
vim.keymap.set('n', '<C-l>', '<C-w><C-l>')
vim.keymap.set('n', '<C-j>', '<C-w><C-j>')
vim.keymap.set('n', '<C-k>', '<C-w><C-k>')

-- keep a block of text selected after indent or deindent
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- make
vim.keymap.set('n', '<leader>m', '<Cmd>make!<CR>')

-- Use :tselect instead of :tag when there are multiple match
vim.keymap.set('n', '<C-]>',
function()
    -- Get the word under the cursor presently
    local word = vim.fn.expand('<cword>')
    local taglist = vim.fn.taglist('^' .. word .. '$')
    local len = #taglist
    if len == 0 then
        print("Tag not found: " .. word)
    elseif len == 1 then
        vim.cmd('tag ' .. word)
    else
        vim.cmd('tselect ' .. word)
    end
end)

-- open quickfix list
vim.keymap.set('n', '<leader>q',
    function()
        local wininfo = vim.fn.getwininfo()
        for _, w in ipairs(wininfo) do
            if w.quickfix == 1 then
                return
            end
        end
        vim.cmd('botright copen 15')
    end)

-- Go to the next tab page
vim.keymap.set('n', '<Tab>', ':tabnext<CR>')

-- Go to the previous tab page
vim.keymap.set('n', '<S-Tab>', '<cmd> tabprev <CR>')

-- Go to the <n>st tab page or create it if doesn't exists
local function goto_or_create_tab(tabidx)
	local tabs = vim.fn.tabpagenr("$")
	for i = 1, tabidx - tabs do
    	vim.cmd("tabnew")
	end
	vim.cmd("tabnext " .. tabidx)
end

vim.keymap.set('n', '<leader>1', function() goto_or_create_tab(1) end)
vim.keymap.set('n', '<leader>2', function() goto_or_create_tab(2) end)
vim.keymap.set('n', '<leader>3', function() goto_or_create_tab(3) end)
vim.keymap.set('n', '<leader>4', function() goto_or_create_tab(4) end)
vim.keymap.set('n', '<leader>5', function() goto_or_create_tab(5) end)
vim.keymap.set('n', '<leader>6', function() goto_or_create_tab(6) end)
vim.keymap.set('n', '<leader>7', function() goto_or_create_tab(7) end)
vim.keymap.set('n', '<leader>8', function() goto_or_create_tab(8) end)
vim.keymap.set('n', '<leader>9', function() goto_or_create_tab(9) end)

-- [[ lsp config ]] --
-- check lsp info: :checkhealth vim.lsp

-- CCLS
-- config:  https://github.com/neovim/nvim-lspconfig/blob/master/lsp/ccls.lua
-- install: https://github.com/MaskRay/ccls

local function switch_source_header(client, bufnr)
  local method_name = 'textDocument/switchSourceHeader'
  local params = vim.lsp.util.make_text_document_params(bufnr)
  client:request(method_name, params, function(err, result)
    if err then
      error(tostring(err))
    end
    if not result then
      vim.notify('corresponding file cannot be determined')
      return
    end
    vim.cmd.edit(vim.uri_to_fname(result))
  end, bufnr)
end

vim.lsp.config.ccls = {
  cmd = { 'ccls' },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
  root_markers = { 'compile_commands.json', '.ccls', '.git' },
  offset_encoding = 'utf-32',
  -- ccls does not support sending a null root directory
  workspace_required = true,
  on_attach = function(client, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, 'LspCclsSwitchSourceHeader', function()
      switch_source_header(client, bufnr)
    end, { desc = 'Switch between source/header' })
  end,
}

-- JDTLS
-- config:  https://github.com/neovim/nvim-lspconfig/blob/master/lsp/jdtls.lua
-- install: https://github.com/eclipse-jdtls/eclipse.jdt.ls

local function get_jdtls_cache_dir()
  return vim.fn.stdpath('cache') .. '/jdtls'
end

local function get_jdtls_workspace_dir()
  return get_jdtls_cache_dir() .. '/workspace'
end

local function get_jdtls_jvm_args()
  local env = os.getenv('JDTLS_JVM_ARGS')
  local args = {}
  for a in string.gmatch((env or ''), '%S+') do
    local arg = string.format('--jvm-arg=%s', a)
    table.insert(args, arg)
  end
  return unpack(args)
end

local root_markers1 = {
  -- Multi-module projects
  'mvnw', -- Maven
  'gradlew', -- Gradle
  'settings.gradle', -- Gradle
  'settings.gradle.kts', -- Gradle
  -- Use git directory as last resort for multi-module maven projects
  -- In multi-module maven projects it is not really possible to determine what is the parent directory
  -- and what is submodule directory. And jdtls does not break if the parent directory is at higher level than
  -- actual parent pom.xml so propagating all the way to root git directory is fine
  '.git',
}
local root_markers2 = {
  -- Single-module projects
  'build.xml', -- Ant
  'pom.xml', -- Maven
  'build.gradle', -- Gradle
  'build.gradle.kts', -- Gradle
}

vim.lsp.config.jdtls = {
  cmd = function(dispatchers, config)
    local workspace_dir = get_jdtls_workspace_dir()
    local data_dir = workspace_dir

    if config.root_dir then
      data_dir = data_dir .. '/' .. vim.fn.fnamemodify(config.root_dir, ':p:h:t')
    end

    local config_cmd = {
      'jdtls',
      '-data',
      data_dir,
      get_jdtls_jvm_args(),
    }

    return vim.lsp.rpc.start(config_cmd, dispatchers, {
      cwd = config.cmd_cwd,
      env = config.cmd_env,
      detached = config.detached,
    })
  end,
  filetypes = { 'java' },
  root_markers = vim.list_extend(root_markers1, root_markers2),
  init_options = {},
}

vim.lsp.enable({
    'ccls',
    'jdtls',
})

