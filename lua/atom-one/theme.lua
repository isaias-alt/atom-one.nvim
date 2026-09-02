local M = {}

-- colors/atom-one-night-flat.lua etc want `variant = "night_flat"` (a valid
-- Lua module name) to resolve to the `:colorscheme` name `atom-one-night-flat`.
local function colors_name(variant)
  if variant == "onedark" then
    return "atom-one"
  end
  return "atom-one-" .. variant:gsub("_", "-")
end

function M.setup()
  local config = require("atom-one.config")
  local opts = config.options

  local colors = require("atom-one.colors." .. opts.variant).setup()
  opts.on_colors(colors)

  local groups = require("atom-one.groups").setup(colors, opts)

  if opts.transparent then
    groups.Normal = { fg = colors.fg, bg = colors.none }
    groups.NormalNC = { fg = colors.fg, bg = colors.none }
  end

  if vim.g.colors_name then
    vim.cmd("hi clear")
  end

  vim.o.termguicolors = true
  vim.g.colors_name = colors_name(opts.variant)

  for group, hl in pairs(groups) do
    hl = type(hl) == "string" and { link = hl } or hl
    vim.api.nvim_set_hl(0, group, hl)
  end

  if opts.terminal_colors then
    M.terminal(colors)
  end

  return colors, groups, opts
end

---@param colors atom-one.Palette
function M.terminal(colors)
  local t = colors.terminal

  vim.g.terminal_color_0 = t.black
  vim.g.terminal_color_1 = t.red
  vim.g.terminal_color_2 = t.green
  vim.g.terminal_color_3 = t.yellow
  vim.g.terminal_color_4 = t.blue
  vim.g.terminal_color_5 = t.magenta
  vim.g.terminal_color_6 = t.cyan
  vim.g.terminal_color_7 = t.white

  vim.g.terminal_color_8 = t.black_bright
  vim.g.terminal_color_9 = t.red_bright
  vim.g.terminal_color_10 = t.green_bright
  vim.g.terminal_color_11 = t.yellow_bright
  vim.g.terminal_color_12 = t.blue_bright
  vim.g.terminal_color_13 = t.magenta_bright
  vim.g.terminal_color_14 = t.cyan_bright
  vim.g.terminal_color_15 = t.white_bright
end

return M
