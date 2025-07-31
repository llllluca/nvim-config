-- Configure diagnostic options globally
local diagnostic_config = {
    virtual_text = false,
    signs = true,
    -- Update diagnostics in Insert mode.
	-- If false, diagnostics are updated on InsertLeave.
    update_in_insert = false,
    underline = false,
    -- This affects the order in which signs and virtual text are displayed.
    -- When true, higher severities are displayed before lower severities
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
}
vim.diagnostic.config(diagnostic_config)

local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, {
        texthl = sign.name,
        numhl = sign.name,
        text = sign.text,
    })
end

