local utils = require("utils")

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>d', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- tabs
vim.keymap.set('n', '<Tab>', '<cmd> tabnext <CR>', { desc = 'Go to the next tab page' })
vim.keymap.set('n', '<S-Tab>', '<cmd> tabprev <CR>', { desc = 'Go to the previous tab page' })
vim.keymap.set('n', '<space>1', '1gt', { desc = 'Go to the 1st tab page' })
vim.keymap.set('n', '<space>2', '2gt', { desc = 'Go to the 2nd tab page' })
vim.keymap.set('n', '<space>3', '3gt', { desc = 'Go to the 3rd tab page' })
vim.keymap.set('n', '<space>4', '4gt', { desc = 'Go to the 4th tab page' })
vim.keymap.set('n', '<space>5', '5gt', { desc = 'Go to the 5th tab page' })
vim.keymap.set('n', '<space>6', '6gt', { desc = 'Go to the 6th tab page' })
vim.keymap.set('n', '<space>7', '7gt', { desc = 'Go to the 7th tab page' })
vim.keymap.set('n', '<space>8', '8gt', { desc = 'Go to the 8th tab page' })
vim.keymap.set('n', '<space>9', '9gt', { desc = 'Go to the 9th tab page' })
vim.keymap.set('n', 'tn', '<cmd> tabnew<CR>', { desc = 'Open a new tab page' })
vim.keymap.set('n', 'tc', '<cmd> tabclose<CR>', { desc = 'Close current tab page' })
vim.keymap.set('n', 'tm', ':tabmove<space>', { desc = 'Move the current tab page to after tab page N' })

-- keep a block of text selected after indent or deindent
vim.keymap.set('v', '<', '<gv', { desc = 'Keep a block of text selected after indent' })
vim.keymap.set('v', '>', '>gv', { desc = 'Keep a block of text selected after deindent' })

-- make
vim.keymap.set('n', '<leader>m', '<Cmd>make!<CR>')

-- tags
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
    end
, { desc = 'Use :tselect instead of :tag when there are multiple match' })

-- quickfix
vim.keymap.set('n', '<leader>q',
    function()
        local wininfo = vim.fn['getwininfo']()
        local isQuckfixOpen = false
        for _, w in ipairs(wininfo) do
            if w.quickfix == 1 then
                isQuckfixOpen = true
                break
            end
        end
        if isQuckfixOpen then
            vim.cmd('cclose')
        else
            vim.cmd('botright copen 15')
        end
    end, { desc = 'Open [Q]uickfix list' })

-- update makeprg cache
local function updateMakeprgCache(new_path, new_prog)
    local makeprg_cache = '/home/luca/.cache/nvim/makeprg_cache.json'
    vim.opt.makeprg = new_prog
    local new = {}
    local entries = utils.json_decode_from_file(makeprg_cache)
    for _, e in ipairs(entries) do
        local path = e.path
        local prog = e.prog
        if path ~= new_path then
            new[#new + 1] = { ["path"] = path, ["prog"] = prog }
        end
    end
    new[#new + 1] = { ["path"] = new_path, ["prog"] = new_prog }
    local prettier = true
    utils.json_encode_into_file(makeprg_cache, new, prettier)
end

vim.keymap.set('n', '<leader>p',
    function()
                vim.ui.input(
            { prompt = 'Set makeprg: ' },
            function(input)
                if input == nil then
                    return
                end
                local dir_path = vim.fn.getcwd() .. '/'
                updateMakeprgCache(dir_path, input)
            end
        )
    end)

