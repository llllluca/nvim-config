-- https://gitlab.com/madyanov/gruber.vim

vim.opt.termguicolors = true

vim.opt.background = "dark"

local black      = "#1c1c1c"
local lightblack = "#262626"
local darkgray   = "#444444"
local gray       = "#626262"
local lightgray  = "#989898"
local white      = "#e4e4e4"
local red        = "#ff5f5f"
local green      = "#87d75f"
local yellow     = "#ffd700"
local blue       = "#87afd7"
local magenta    = "#afafd7"
local cyan       = "#afd7af"
local brown      = "#af875f"
-- local purple     = { gui="#c154c1" }

local hi = function(group, args)
	vim.api.nvim_set_hl(0, group, args)
end

local constant   = { fg=white }
local identifier = { fg=white }
local special    = { fg=white }
local operator   = { fg=white }
local comment    = { fg=brown }
local preproc    = { fg=cyan }
local keyword    = { fg=yellow, bold=true }
local _type      = { fg=lightgray }
local typedef    = { fg=white }
local _function  = { fg=blue }
local literal    = { fg=magenta }
local string     = { fg=green }
local char       = { fg=cyan }

-- Modes
hi("Normal",      { fg=white, bg=black })
hi("NormalFloat", { link='Normal' })
hi("NormalNC",    { link='Normal' })
hi("MsgArea",     { link='Normal' })

hi("Visual", { bg=gray })
hi("VisualNOS", { link='Visual' })

-- Syntax
hi("Comment",          comment)
hi("Constant",         constant)
hi("String",           string)
hi("Character",        char)
hi("Number",           literal)
hi("Boolean",          literal)
hi("Float",            literal)
hi("Identifier",       identifier)
hi("Function",         _function)
hi("Statement",        keyword)
hi("Operator",         operator)
hi("PreProc",          preproc)
hi("Type",             _type)
hi("Special",          special)
hi("SpecialChar",      char)
hi("SpecialComment",   comment)
hi("Underlined",       { underline=true })
hi("Ignore",           { fg=black })
hi("Error",            { fg=red })
hi("Todo",             comment)
hi("@type.definition", typedef)

-- Cursor
hi("Cursor",       { fg=black, bg=white })
hi("TermCursorNC", { fg=black, bg=gray })
hi("lCursor",      { link="Cursor" })
hi("CursorIM",     { link="Cursor" })
hi("TermCursor",   { link="Cursor" })
hi("CursorLine",   { bg=lightblack })
hi("CursorColumn", { link="CursorLine" })
hi("CursorLineNr", { bold=true })

-- Line numbers
hi("LineNr",     { fg=gray })
hi("SignColumn", { bg=black })

-- Status line
hi("StatusLine",   { fg=white, bg=lightblack })
hi("StatusLineNC", { fg=gray, bg=lightblack })

-- Search
hi("Search",    { fg=white, bg=gray })
hi("IncSearch", { fg=black, bg=yellow, bold=true })
hi("CurSearch", { link="IncSearch"})

-- Completion
hi("Pmenu",      { fg=white, bg=darkgray })
hi("PmenuSel",   { fg=white, bg=gray, bold=true })
hi("PmenuSBar",  { bg=darkgray })
hi("PmenuThumb", { bg=gray })
hi("WildMenu",   { fg=white, bg=gray, bold=true })

-- Tabs
hi("TabLine",     { fg=gray, bg=lightblack })
hi("TabLineFill", { link="TabLine" })

hi("TabLineSel", { fg=white, bold=true, italic=true })
hi("Title",      { fg=yellow, bold=true })

-- Diff
hi("DiffAdd",    { fg=black, bg=green })
hi("DiffDelete", { fg=black, bg=red })
hi("DiffChange", { fg=black, bg=blue })
hi("DiffText",   { fg=black, bg=blue, bold= true, italic=true })

-- GitSigns
hi("GitSignsAdd",    { fg=green })
hi("GitSignsDelete", { fg=red })
hi("GitSignsChange", { fg=blue })

-- Messages
hi("ModeMsg",      { bold=true })
hi("MsgSeparator", { fg=gray })
hi("ErrorMsg",     { fg=red })
hi("WarningMsg",   { fg=yellow })
hi("MoreMsg",      { fg=green })
hi("Question",     { fg=green })

-- Spell
hi("SpellBad",   { underline=true })
hi("SpellCap",   { underline=true })
hi("SpellLocal", { undercurl=true })
hi("SpellRare",  { underdotted=true })

-- Folding
hi("Folded",     { fg=brown, bg=lightblack, italic=true })
hi("FoldColumn", { fg=brown })

-- Diagnostic
hi("DiagnosticError", { fg=red })
hi("DiagnosticWarn",  { fg=yellow })
hi("DiagnosticInfo",  { fg=blue })
hi("DiagnosticHint",  { fg=gray })

-- Indentation
hi("ColorColumn", { bg=lightblack })
hi("NonText",     { fg=darkgray })

-- Splits
hi("VertSplit",    { fg=gray })
hi("WinSeparator", { fg=gray })

-- WinBar
hi("WinBar",   { fg=magenta, bold=true })
hi("WinBarNC", { link="WinBar"})

-- Misc
hi("MatchParen",        { fg=yellow, bold=true })
hi("QuickFixLine",      { bg=gray, bold=true })
hi("SpecialKey",        { fg=magenta })
hi("Conceal",           { fg=magenta })
hi("Directory",         { fg=blue })
hi("EndOfBuffer",       { fg=black })
hi("NvimInternalError", { fg=black, bg=red })

-- Java 
-- Make type keyword (e.g. suffix class in ClassName.class) as Type
hi("@lsp.type.keyword.java",  { link='Type' })
-- Make type modifier (e.g. static, final) as Statement
hi("@lsp.type.modifier.java", { link='Statement' })
-- Make builtin type (e.g. int, boolean) as Type
hi("@type.builtin.java",      { link='Type' })

-- C
-- Make builtin type (e.g. int, unsigned int, char) as Type
hi("@type.builtin.c",   { link='Type' })
hi("@keyword.directive.cpp", { link='PreProc' })
hi("@keyword.directive.define.cpp", { link='PreProc' })
hi("@keyword.import.cpp", { link='PreProc' })
hi("@keyword.import.c", { link='PreProc' })

-- Go
hi("@type.builtin.go",   { link='Type' })

-- Rust
hi("@type.builtin.rust",        { link='Type' })
hi("@lsp.mod.attribute.rust",   { link='PreProc' })
