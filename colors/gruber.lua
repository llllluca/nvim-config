vim.cmd("highlight clear");
vim.g.colors_name = "gruber"

local fg    = "#e4e4e4"
local bg    = "#181818"
-- Lighter backgrounds, bg_l<n+1> is lighter than bg_l<n>
local bg_l1 = "#282828"
local bg_l2 = "#383838"
local bg_l3 = "#484848"
local bg_l4 = "#686868"

local black    = "#000000"
local white    = "#ffffff"
local red      = "#f43841"
local green    = "#73d936"
local yellow   = "#ffdd33"
local brown    = "#cc8c3c"
local quarz    = "#95a99f"
local niagara  = "#96a6c8"
local wisteria = "#9e95c7"
local cyan     = "#afd7af"

local hi = function(group, args)
	vim.api.nvim_set_hl(0, group, args)
end

-- Basic editor highlight groups (:help highlight-groups)
hi("ColorColumn",    { bg=bg_l2 })
hi("Conceal",        { fg=fg, bg=bg })
hi("CurSearch",      { link="IncSearch"})
hi("Cursor",         { fg=bg, bg=fg })
hi("lCursor",        { link="Cursor" })
hi("CursorIM",       { link="Cursor" })
hi("CursorLine",     { bg=bg_l1 })
hi("CursorColumn",   { bg=bg_l2 })
hi("Directory",      { fg=niagara, bold=true })
hi("DiffAdd",        { fg=green })
hi("DiffChange",     { fg=yellow })
hi("DiffDelete",     { fg=red })
hi("DiffText",       { fg=yellow })
hi("EndOfBuffer",    { fg=bg_l4 })
hi("TermCursor",     { link="Cursor" })
hi("OkMsg",          { fg=green })
hi("ErrorMsg",       { fg=red })
hi("WarningMsg",     { fg=yellow })
hi("StderrMsg",      { fg=red })
hi("StdoutMsg",      { fg=fg })
hi("WinSeparator",   { fg=bg_l2,  bold=true })
hi("Folded",         { fg=brown, bg=bg_l2, italic=true })
hi("FoldColumn",     { fg=brown, bg=bg_l2})
hi("SignColumn",     { bg=bg })
hi("IncSearch",      { fg=black, bg=yellow, bold=true })
hi("LineNr",         { fg=bg_l4 })
hi("LineNrAbove",    { link="LineNr" })
hi("LineNrBelow",    { link="LineNr" })
hi("CursorLineNr",   { bold=true })
hi("CursorLineFold", { link="FoldColumn" })
hi("CursorLineSign", { link="SignColumn" })
hi("MatchParen",     { fg=yellow, bold=true })
hi("ModeMsg",        { fg=white, bold=true })
hi("NonText",        { link="EndOfBuffer" })
hi("Normal",         { fg=fg, bg=bg })
hi("NormalFloat",    { fg=fg, bg=bg })
hi("FloatBorder",    { fg=fg, bg=bg })
hi("NormalNC",       { link="Normal" })
hi("Pmenu",          { fg=fg, bg=bg_l1 })
hi("PmenuSel",       { fg=fg, bg=bg_l2 })
hi("PmenuSBar",      { bg=bg })
hi("PmenuThumb",     { bg=bg })
hi("Question",       { fg=niagara })
hi("QuickFixLine",   { bg=bg_l2, bold=true })
hi("Search",         { fg=fg, bg=bg_l4 })
hi("SpecialKey",     { fg=white })
hi("SpellBad",       { fg=red, underline=true })
hi("SpellCap",       { undercurl=true })
hi("SpellLocal",     { undercurl=true })
hi("SpellRare",      { undercurl=true })
hi("StatusLine",     { fg=white, bg=bg_l2 })
hi("StatusLineNC",   { fg=quarz, bg=bg_l1 })
hi("TabLine",        { fg=fg, bg=bgLl1 })
hi("TabLineFill",    { bg=bg_l1 })
hi("TabLineSel",     { fg=white, bold=true, italic=true })
hi("Title",          { fg=quarz, bold=true })
hi("Visual",         { bg=bg_l2, reverse=true })
hi("VisualNOS",      { link="Visual" })
hi("Whitespace",     { fg=bg_l4 })
hi("WildMenu",       { fg=white, bg=bg_l4, bold=true })
hi("WinBar",         { fg=white, bold=true })
hi("WinBarNC",       { fg=quarz })

-- Diagnostic highlight groups (:help diagnostic-highlights)
hi("DiagnosticError", { fg=red })
hi("DiagnosticWarn",  { fg=yellow })
hi("DiagnosticInfo",  { fg=niagara })
hi("DiagnosticHint",  { fg=bg_l4 })
hi("DiagnosticOk",    { fg=green })

-- Standard syntax highlight groups (:help group-name)
hi("Comment",        { fg=brown })
hi("Constant",       { fg=quarz })
hi("String",         { fg=green })
hi("Character",      { fg=green })
hi("Number",         { fg=wisteria })
hi("Boolean",        { fg=yellow, bold=true })
hi("Float",          { fg=wisteria })
hi("Identifier",     { fg=fg })
hi("Function",       { fg=niagara })
hi("Statement",      { fg=yellow, bold=true })
hi("Conditional",    { link="Statement" })
hi("Repeat",         { link="Statement" })
hi("Label",          { link="Statement" })
hi("Operator",       { fg=fg })
hi("Keyword",        { link="Statement" })
hi("Exception",      { link="Statement" })
hi("PreProc",        { fg=cyan })
hi("Type",           { fg=quarz })
hi("StorageClass",   { link="Statement" })
hi("Structure",      { link="Statement" })
hi("Typedef",        { link="Statement" })
hi("Special",        { fg=fg })
hi("SpecialChar",    { fg=cyan })
hi ("Delimiter",     { fg=fg })
hi("SpecialComment", { fg=wisteria, bold=true })
hi("Debug",          { fg=fg })
hi("Underlined",     { underline=true })
hi("Ignore",         { link="Normal" })
hi("Error",          { fg=bg, bg=red })
hi("Todo",           { fg=bg, bg=yellow })

-- Treesitter Highlight Groups (:help treesitter-highlight-groups)
hi("@variable", { link="Identifier" })

-- Java
hi("@lsp.type.keyword.java",  { link="Type" })
hi("@lsp.type.modifier.java", { link="Statement" })
hi("@type.builtin.java",      { link="Type" })

-- C/C++
hi("@type.builtin.c",               { link="Type" })
hi("@type.builtin.cpp",             { link="Type" })
hi("@keyword.import.c",             { link="PreProc" })
hi("@keyword.directive.cpp",        { link="PreProc" })
hi("@keyword.directive.define.cpp", { link="PreProc" })
hi("@keyword.import.cpp",           { link="PreProc" })

-- Lua
hi("@constructor.lua", { link="Delimiter" })

