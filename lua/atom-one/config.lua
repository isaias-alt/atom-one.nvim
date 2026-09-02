local M = {}

---@class atom-one.Config
---@field variant "onedark"|"darker"|"flat"|"mix"|"night_flat"
---@field transparent boolean
---@field terminal_colors boolean
---@field styles table<string, table>
---@field on_colors fun(colors: atom-one.Palette)
---@field on_highlights fun(highlights: table, colors: atom-one.Palette)
local defaults = {
  variant = "onedark", -- which colors/*.lua palette `:colorscheme atom-one` loads
  transparent = false, -- don't set a background color, let the terminal show through
  terminal_colors = true, -- set g:terminal_color_0..15 for `:terminal`

  styles = {
    -- Style to be applied to different syntax groups.
    -- Value is any valid attr-list value for `:help nvim_set_hl`.
    -- NOTE: One Dark Pro's own tokenColors don't italicize keywords (unlike
    -- tokyonight/solarized-osaka's defaults) - only comments and a handful
    -- of JS/TS-specific scopes (attribute names, parameters) are italic in
    -- the upstream Binaryify/OneDark-Pro VS Code theme.
    comments = { italic = true },
    keywords = {},
    functions = {},
    variables = {},
  },

  --- Override palette colors before they're used to build highlight groups.
  ---@param colors atom-one.Palette
  on_colors = function(colors) end,

  --- Override specific highlight groups after they're built.
  ---@param highlights table
  ---@param colors atom-one.Palette
  on_highlights = function(highlights, colors) end,
}

---@type atom-one.Config
M.options = {}

---@param options atom-one.Config|nil
function M.setup(options)
  M.options = vim.tbl_deep_extend("force", {}, defaults, options or {})
end

---@param options atom-one.Config|nil
function M.extend(options)
  M.options = vim.tbl_deep_extend("force", {}, M.options or defaults, options or {})
end

M.setup()

return M
