-- Core editor UI + classic vim syntax groups.
--
-- The classic syntax groups here (Comment, String, Keyword, Type, ...) are
-- deliberately colored straight from the generic (language-agnostic)
-- tokenColors scopes in the upstream Binaryify/OneDark-Pro VS Code theme
-- (e.g. bare `comment`, `string`, `keyword.control`, `entity.name.type`).
-- groups/treesitter.lua links most `@capture`s straight to these instead of
-- repeating hex values, the same way tokyonight/solarized-osaka do it.
--
-- UI-chrome values cite the `colors.*` VS Code key they come from; where
-- the source uses an alpha color, the palette module has already resolved
-- it to an opaque hex via Util.blend (see colors/onedark.lua).

local M = {}

---@param c atom-one.Palette
---@param opts atom-one.Config
function M.get(c, opts)
  -- stylua: ignore
  return {
    -- Editor
    Normal                      = { fg = c.fg, bg = c.bg },
    NormalNC                    = { fg = c.fg, bg = c.bg },
    NormalFloat                 = { fg = c.fg, bg = c.bg_popup },
    FloatBorder                 = { fg = c.border, bg = c.bg_popup },
    FloatTitle                  = { fg = c.blue, bg = c.bg_popup },
    ColorColumn                 = { bg = c.bg_highlight },
    Cursor                      = { fg = c.bg, bg = c.cursor }, -- editorCursor.foreground
    lCursor                     = "Cursor",
    CursorIM                    = "Cursor",
    CursorColumn                = { bg = c.bg_highlight },
    CursorLine                  = { bg = c.bg_highlight }, -- editor.lineHighlightBackground
    LineNr                      = { fg = c.fg_gutter }, -- editorLineNumber.foreground
    CursorLineNr                = { fg = c.fg }, -- editorLineNumber.activeForeground
    Directory                   = { fg = c.blue },
    EndOfBuffer                 = { fg = c.bg },
    ErrorMsg                    = { fg = c.error },
    WarningMsg                  = { fg = c.warning },
    ModeMsg                     = { fg = c.fg_dark, bold = true },
    MsgArea                     = { fg = c.fg_dark },
    MoreMsg                     = { fg = c.blue },
    NonText                     = { fg = c.fg_gutter },
    Whitespace                  = { fg = c.whitespace }, -- editorWhitespace.foreground
    SpecialKey                  = { fg = c.fg_gutter },
    VertSplit                   = { fg = c.border },
    WinSeparator                = { fg = c.border, bold = true },
    Folded                      = { fg = c.blue, bg = c.bg_highlight },
    FoldColumn                  = { fg = c.fg_gutter, bg = c.bg },
    SignColumn                  = { fg = c.fg_gutter, bg = c.bg },
    MatchParen                  = { fg = c.white, bg = c.border_highlight, bold = true }, -- editorBracketMatch.{background,border}
    Pmenu                       = { fg = c.fg, bg = c.bg_popup }, -- editorSuggestWidget.background
    PmenuSel                    = { bg = c.bg_highlight }, -- editorSuggestWidget.selectedBackground
    PmenuSbar                   = { bg = c.bg_popup },
    PmenuThumb                  = { bg = c.fg_gutter },
    Question                    = { fg = c.blue },
    QuickFixLine                = { bg = c.bg_visual, bold = true },
    Search                      = { bg = c.bg_search }, -- editor.findMatchBackground
    IncSearch                   = { bg = c.bg_search, bold = true },
    CurSearch                   = "IncSearch",
    Substitute                  = { fg = c.bg, bg = c.red },
    SpellBad                    = { sp = c.error, undercurl = true },
    SpellCap                    = { sp = c.warning, undercurl = true },
    SpellLocal                  = { sp = c.info, undercurl = true },
    SpellRare                   = { sp = c.hint, undercurl = true },
    StatusLine                  = { fg = c.fg_dark, bg = c.bg_statusline }, -- statusBar.{foreground,background}
    StatusLineNC                = { fg = c.fg_gutter, bg = c.bg_statusline },
    TabLine                     = { fg = c.fg_gutter, bg = c.bg_dark },
    TabLineFill                 = { bg = c.bg_dark },
    TabLineSel                  = { fg = c.fg, bg = c.bg },
    Title                       = { fg = c.blue, bold = true },
    Visual                      = { bg = c.bg_visual }, -- editor.selectionBackground
    VisualNOS                   = { bg = c.bg_visual },
    WildMenu                    = { fg = c.fg, bg = c.bg_visual },
    WinBar                      = "StatusLine",
    WinBarNC                    = "StatusLineNC",

    -- Native LSP client
    LspReferenceText            = { bg = c.word_highlight }, -- editor.wordHighlightBackground
    LspReferenceRead            = "LspReferenceText",
    LspReferenceWrite           = { bg = c.word_highlight_strong }, -- editor.wordHighlightStrongBackground
    LspSignatureActiveParameter = { bg = c.bg_visual, bold = true },
    LspCodeLens                 = { fg = c.fg_gutter },
    LspInlayHint                = { fg = c.fg, bg = c.bg_highlight }, -- editorInlayHint.{foreground,background}
    LspInfoBorder               = { fg = c.border, bg = c.bg_popup },

    -- Diagnostics
    DiagnosticError             = { fg = c.error }, -- editorError.foreground
    DiagnosticWarn              = { fg = c.warning }, -- editorWarning.foreground
    DiagnosticInfo              = { fg = c.info },
    DiagnosticHint              = { fg = c.hint },
    DiagnosticOk                = { fg = c.green },
    DiagnosticUnnecessary       = { fg = c.fg_gutter },
    DiagnosticVirtualTextError  = { fg = c.error },
    DiagnosticVirtualTextWarn   = { fg = c.warning },
    DiagnosticVirtualTextInfo   = { fg = c.info },
    DiagnosticVirtualTextHint   = { fg = c.hint },
    DiagnosticVirtualTextOk     = { fg = c.green },
    DiagnosticUnderlineError    = { undercurl = true, sp = c.error },
    DiagnosticUnderlineWarn     = { undercurl = true, sp = c.warning },
    DiagnosticUnderlineInfo     = { undercurl = true, sp = c.info },
    DiagnosticUnderlineHint     = { undercurl = true, sp = c.hint },
    DiagnosticUnderlineOk       = { undercurl = true, sp = c.green },

    -- health.vim
    healthError                  = { fg = c.error },
    healthSuccess                = { fg = c.green },
    healthWarning                = { fg = c.warning },

    -- Diffs
    DiffAdd                     = { bg = c.diff.add },
    DiffChange                  = { bg = c.diff.change },
    DiffDelete                  = { bg = c.diff.delete },
    DiffText                    = { bg = c.diff.text, bold = true },
    diffAdded                   = { fg = c.green },
    diffRemoved                 = { fg = c.red },
    diffChanged                 = { fg = c.orange },
    diffOldFile                 = { fg = c.yellow },
    diffNewFile                 = { fg = c.orange },
    diffFile                    = { fg = c.blue },
    diffLine                    = { fg = c.fg_gutter },
    diffIndexLine               = { fg = c.magenta },

    -- Classic vim syntax groups.
    -- Treesitter `@capture`s (groups/treesitter.lua) link to most of these
    -- instead of repeating hex - see that file's header comment.
    Comment                     = { fg = c.comment, style = opts.styles.comments }, -- tokenColors: "Comments"
    Constant                    = { fg = c.orange }, -- tokenColors: bare `constant`
    String                      = { fg = c.green }, -- tokenColors: bare `string`
    Character                   = "String",
    Number                      = { fg = c.orange }, -- tokenColors: `constant.numeric`
    Boolean                     = "Number",
    Float                       = "Number",
    Identifier                  = { fg = c.red, style = opts.styles.variables }, -- tokenColors: `variable.other.readwrite`
    Function                    = { fg = c.blue, style = opts.styles.functions }, -- tokenColors: `entity.name.function`
    Statement                   = { fg = c.magenta }, -- tokenColors: `keyword.control`
    Conditional                 = "Statement",
    Repeat                      = "Statement",
    Label                       = { fg = c.red }, -- tokenColors: `entity.name.label`
    Operator                    = { fg = c.cyan }, -- tokenColors: `keyword.operator.arithmetic` et al
    Keyword                     = { fg = c.magenta, style = opts.styles.keywords }, -- tokenColors: bare `keyword`
    Exception                   = "Statement",
    PreProc                     = { fg = c.magenta },
    Include                     = "Keyword", -- tokenColors: bare `keyword.control` (plain import/#include/use) - see groups/treesitter.lua's @keyword.import comment
    Define                      = "PreProc",
    Macro                       = { fg = c.blue },
    PreCondit                   = "PreProc",
    Type                        = { fg = c.yellow }, -- tokenColors: `entity.name.type`
    StorageClass                = { fg = c.magenta }, -- tokenColors: bare `storage`
    Structure                   = "Type",
    Typedef                     = "Type",
    Special                     = { fg = c.cyan },
    SpecialChar                 = { fg = c.cyan }, -- tokenColors: `constant.character.escape`
    Tag                         = { fg = c.red }, -- tokenColors: `entity.name.tag`
    Delimiter                   = { fg = c.fg },
    SpecialComment              = "Comment",
    Debug                       = { fg = c.orange },
    Underlined                  = { underline = true },
    Ignore                      = { fg = c.comment },
    Error                       = { fg = c.error },
    Todo                        = { fg = c.orange, bold = true }, -- tokenColors: `todo.bold`
  }
end

return M
