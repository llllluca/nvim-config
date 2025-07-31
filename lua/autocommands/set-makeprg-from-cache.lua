local utils = require("utils")

local function setMakeprgOption()
    local makeprg_cache = '/home/luca/.cache/nvim/makeprg_cache.json'
    local entries = utils.json_decode_from_file(makeprg_cache)
    local dir_path = vim.fn.getcwd() .. '/'
    local max_len = 0
    local prog = nil
    local path = nil
    for _, e in ipairs(entries) do
        path =  e.path
        local _, len = string.find(dir_path , '^' .. path)
        if len ~= nil and  len > max_len then
            max_len = len
            prog = e.prog
        end
    end
    if prog ~= nil then
        vim.opt.makeprg = prog
    end
end

vim.api.nvim_create_autocmd("VimEnter", {
    desc = "Set makeprg variable according to current working directory",
    group = vim.api.nvim_create_augroup('set-makeprg', { clear = true }),
    callback = setMakeprgOption
})

