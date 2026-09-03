-- Palette for `atom-one-night-flat`.
-- Ground truth: `OneDark-Pro-night-flat.json` in
-- github.com/Binaryify/OneDark-Pro (MIT).
--
-- The darkest variant: editor.background drops to #16191d and, like `flat`,
-- sidebar/statusline share it exactly. `editorLineNumber.foreground` is also
-- distinct here (#667187, brighter than the other 4 variants' #495162) to
-- stay legible against the much darker background. Night-flat's
-- `tokenColors` genuinely differ in count from the base theme (272 vs 275
-- entries) but the shared 8-color syntax palette below is identical - the
-- divergence is in rarely-hit language-specific scopes outside this
-- plugin's generic Treesitter/semantic-token scope.

local Util = require("atom-one.util")

local M = {}

function M.setup()
  local bg = "#16191d" -- editor.background

  ---@class atom-one.Palette
  local c = {
    none = "NONE",

    bg = bg,
    bg_dark = "#16191d", -- sideBar.background, statusBar.background (== bg: flat)
    bg_popup = "#1e2227", -- editorWidget/editorSuggestWidget/editorHoverWidget.background
    bg_statusline = "#16191d", -- statusBar.background (== bg: flat)
    bg_highlight = "#2c313c", -- editor.lineHighlightBackground
    bg_visual = Util.blend("#677696", 0x60 / 0xff, bg), -- editor.selectionBackground
    bg_search = Util.blend("#d19a66", 0x44 / 0xff, bg), -- editor.findMatchBackground
    whitespace = Util.blend("#ffffff", 0x1d / 0xff, bg), -- editorWhitespace.foreground
    word_highlight = Util.blend("#d2e0ff", 0x2f / 0xff, bg), -- editor.wordHighlightBackground
    word_highlight_strong = Util.blend("#abb2bf", 0x26 / 0xff, bg), -- editor.wordHighlightStrongBackground

    border = "#181a1f", -- editorGroup.border, tab.border, editorSuggestWidget.border
    border_highlight = "#3e4452", -- focusBorder, panel.border

    fg = "#abb2bf", -- editor.foreground
    fg_dark = "#9da5b4", -- statusBar.foreground
    fg_gutter = "#667187", -- editorLineNumber.foreground

    cursor = "#528bff", -- editorCursor.foreground
    comment = "#7f848e", -- tokenColors: "Comments" (italic)
    gray = "#5c6370", -- tokenColors: secondary muted scopes (markdown quote, comment markup.link)

    red = "#e06c75",
    orange = "#d19a66",
    yellow = "#e5c07b",
    green = "#98c379",
    cyan = "#56b6c2",
    blue = "#61afef",
    magenta = "#c678dd",
    white = "#ffffff",

    error = "#c24038", -- editorError.foreground
    warning = "#d19a66", -- editorWarning.foreground
    info = "#61afef",
    hint = "#56b6c2",

    diff = {
      -- Bumped past the VS Code ground-truth alphas (0x33/0.15/0.25): at
      -- those values add/delete/change wash out against a dark bg and read
      -- as barely-there gray, especially in diffview.nvim/neogit (which
      -- render through these same DiffAdd/DiffDelete/DiffChange groups).
      add = Util.blend("#00809b", 0.35, bg),
      delete = Util.blend("#9a353d", 0.42, bg),
      change = Util.blend("#d19a66", 0.28, bg),
      text = Util.blend("#61afef", 0.32, bg),
    },

    terminal = {
      black = "#3f4451",
      red = "#e05561",
      green = "#8cc265",
      yellow = "#d18f52",
      blue = "#4aa5f0",
      magenta = "#c162de",
      cyan = "#42b3c2",
      white = "#d7dae0",
      black_bright = "#4f5666",
      red_bright = "#ff616e",
      green_bright = "#a5e075",
      yellow_bright = "#f0a45d",
      blue_bright = "#4dc4ff",
      magenta_bright = "#de73ff",
      cyan_bright = "#4cd1e0",
      white_bright = "#e6e6e6",
    },
  }

  return c
end

return M
