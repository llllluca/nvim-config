-- https://gitlab.com/madyanov/gruber.vim

vim.opt.termguicolors = true
if vim.g.colors_name then vim.cmd('highlight clear') end
vim.g.colors_name = nil
vim.opt.background='dark'

local black      = { gui="#1c1c1c" }
local lightblack = { gui="#262626" }
local darkgray   = { gui="#444444" }
local gray       = { gui="#626262" }
local lightgray  = { gui="#989898" }
local white      = { gui="#e4e4e4" }
local red        = { gui="#ff5f5f" }
local green      = { gui="#87d75f" }
local yellow     = { gui="#ffd700" }
local blue       = { gui="#87afd7" }
local magenta    = { gui="#afafd7" }
local cyan       = { gui="#afd7af" }
local brown      = { gui="#af875f" }
-- local purple     = { gui="#c154c1" }

local hi = function(group, args)
  local command
  if args.link ~= nil then
    command = string.format('highlight! link %s %s', group, args.link)
  else
    command = string.format(
      'highlight %s guifg=%s ctermfg=%s guibg=%s ctermbg=%s gui=%s cterm=%s guisp=%s blend=%s',
      group,
      args.fg and args.fg.gui or 'NONE',
      args.fg and args.fg.cterm or 'NONE',
      args.bg and args.bg.gui or 'NONE',
      args.bg and args.bg.cterm or 'NONE',
      args.attr or 'NONE',
      args.attr or 'NONE',
      args.sp and args.sp.gui or 'NONE',
      args.blend or 'NONE'
    )
  end
  vim.cmd(command)
end

local constant   = { fg=white }
local identifier = { fg=white }
local special    = { fg=white }
local operator   = { fg=white }
local comment    = { fg=brown }
local preproc    = { fg=cyan }
local keyword    = { fg=yellow, attr="bold" }
local _type       = { fg=lightgray }
local typedef    = { fg=white }
local _function  = { fg=blue }
local literal    = { fg=magenta }
local string     = { fg=green }
local char       = { fg=cyan }
-- local info       = { attr="italic" }

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
hi("Underlined",       { attr="underline" })
hi("Ignore",           black)
hi("Error",            red)
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
hi("CursorLineNr", { attr="bold" })

-- Line numbers
hi("LineNr",     { fg=gray })
hi("SignColumn", { bg=black })

-- Status line
hi("StatusLine",   { fg=white, bg=lightblack })
hi("StatusLineNC", { fg=gray, bg=lightblack })

-- Search
hi("Search",    { fg=white, bg=gray })
hi("IncSearch", { fg=black, bg=yellow, attr="bold" })
hi("CurSearch", { link="IncSearch"})

-- Completion
hi("Pmenu",      { fg=white, bg=darkgray })
hi("PmenuSel",   { fg=white, bg=gray, attr="bold" })
hi("PmenuSBar",  { bg=darkgray })
hi("PmenuThumb", { bg=gray })
hi("WildMenu",   { fg=white, bg=gray, attr="bold" })

-- Tabs
hi("TabLine",     { fg=gray, bg=lightblack })
hi("TabLineFill", { link="TabLine" })

hi("TabLineSel", { fg=white, attr="bold,italic" })
hi("Title",      { fg=yellow, attr="bold" })

-- Diff
hi("DiffAdd",    { fg=black, bg=green })
hi("DiffDelete", { fg=black, bg=red })
hi("DiffChange", { fg=black, bg=blue })
hi("DiffText",   { fg=black, bg=blue, attr="bold,italic" })

-- GitSigns
hi("GitSignsAdd",    { fg=green })
hi("GitSignsDelete", { fg=red })
hi("GitSignsChange", { fg=blue })

-- Messages
hi("ModeMsg",      { attr="bold" })
hi("MsgSeparator", { fg=gray })
hi("ErrorMsg",     { fg=red })
hi("WarningMsg",   { fg=yellow })
hi("MoreMsg",      { fg=green })
hi("Question",     { fg=green })

-- Spell
hi("SpellBad",   { attr="underline" })
hi("SpellCap",   { attr="underline" })
hi("SpellLocal", { attr="undercurl" })
hi("SpellRare",  { attr="underdotted" })

-- Folding
hi("Folded",     { fg=brown, bg=lightblack, attr="italic" })
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
hi("WinBar",   { fg=magenta, style='bold' })
hi("WinBarNC", { link="WinBar"})

-- Misc
hi("MatchParen",        { fg=yellow, attr="bold" })
hi("QuickFixLine",      { bg=gray, attr="bold" })
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
