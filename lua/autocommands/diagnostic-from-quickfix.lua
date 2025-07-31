local function setDiagnosticFromQuickfix()
    local qflist = vim.fn.getqflist()
    local filtered_qflist = {}
    for i, l in ipairs(qflist) do
        if l.type == 'e' then
            l.type = 'ERROR'
            table.insert(filtered_qflist, qflist[i])
        elseif l.type == 'w' then
            l.type = 'WARN'
            table.insert(filtered_qflist, qflist[i])
        elseif l.type == 'i' then
            l.type = 'INFO'
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

vim.api.nvim_create_autocmd({ "QuickFixCmdPost", "BufEnter" }, {
  desc = "Set diagnostics for errors in the quickfix buffer",
  group = vim.api.nvim_create_augroup('sign-for-line-with-errros', { clear = true }),
  callback = setDiagnosticFromQuickfix
})

