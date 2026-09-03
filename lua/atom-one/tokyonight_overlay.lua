-- `atom-one-tokyonight`: tokyonight's theme in full, with only "how the
-- code looks" swapped for atom-one-darker's.
--
-- This is NOT another `colors/*.lua` palette variant selected via
-- `opts.variant` - that pipeline (theme.lua -> groups.setup()) only knows
-- how to build the highlight groups this repo defines itself (base,
-- treesitter, semantic_tokens), so composing a palette through it would
-- silently drop every one of tokyonight's plugin-integration groups
-- (telescope, cmp, gitsigns, notify, ...). Instead: apply the real
-- `tokyonight-night` colorscheme first (everything, unmodified), then
-- overlay just the code-highlighting groups with atom-one-darker's.
--
-- Unlike every other colors/atom-one-*.lua entrypoint, this one has a hard
-- runtime dependency on folke/tokyonight.nvim being installed.

local M = {}

-- The classic vim syntax groups from groups/base.lua's own "Classic vim
-- syntax groups" section (kept in sync by hand with that list - it's short
-- and has been stable). Everything else in base.lua (Normal, Diagnostic*,
-- Diff*, Cursor*, Pmenu, StatusLine, ...) is UI/chrome and stays
-- tokyonight's untouched.
local CODE_GROUPS = {
  "Comment", "Constant", "String", "Character", "Number", "Boolean", "Float",
  "Identifier", "Function", "Statement", "Conditional", "Repeat", "Label",
  "Operator", "Keyword", "Exception", "PreProc", "Include", "Define",
  "Macro", "PreCondit", "Type", "StorageClass", "Structure", "Typedef",
  "Special", "SpecialChar", "Tag", "Delimiter", "SpecialComment", "Debug",
  "Underlined", "Ignore", "Error", "Todo",
}

local CODE_GROUP_SET = {}
for _, g in ipairs(CODE_GROUPS) do
  CODE_GROUP_SET[g] = true
end

---@param group string
local function is_code_group(group)
  -- `@foo` (Treesitter captures) and `@lsp.type.foo`/`@lsp.mod.foo`
  -- (semantic tokens) both start with "@" - groups/treesitter.lua and
  -- groups/semantic_tokens.lua define nothing else, so this catches both
  -- modules in full without hand-listing hundreds of capture names.
  return CODE_GROUP_SET[group] or group:sub(1, 1) == "@"
end

function M.setup()
  local ok, tokyonight = pcall(require, "tokyonight")
  if not ok then
    error("atom-one-tokyonight requires folke/tokyonight.nvim to be installed")
  end

  -- 1. Full tokyonight - every UI/chrome/plugin-integration group it
  --    defines, untouched. Calling `require("tokyonight").load(...)`
  --    directly rather than `vim.cmd.colorscheme("tokyonight-night")`:
  --    `:colorscheme` is documented as non-reentrant ("Doesn't work
  --    recursively, thus you can't use ':colorscheme' in a color scheme
  --    script" - :help :colorscheme) and this file IS a color scheme
  --    script (loaded by the outer `:colorscheme atom-one-tokyonight`).
  --    Calling it recursively silently left Normal/etc. on Neovim's
  --    built-in "default" colorscheme instead of tokyonight's.
  tokyonight.load({ style = "night" })

  -- 2. Overlay atom-one-darker's code-highlighting groups on top.
  local atom_colors = require("atom-one.colors.darker").setup()
  local atom_config = require("atom-one.config")
  local atom_groups = require("atom-one.groups").setup(atom_colors, atom_config.options)

  for group, hl in pairs(atom_groups) do
    if is_code_group(group) then
      hl = type(hl) == "string" and { link = hl } or hl
      vim.api.nvim_set_hl(0, group, hl)
    end
  end

  -- 3. One narrow UI exception: tokyonight's own DiffChange is blended at
  --    only 0.15 alpha (blend_bg(blue7, 0.15) in tokyonight/colors/init.lua)
  --    - nearly invisible against this bg, the exact same low-contrast
  --    problem already fixed for the 5 official atom-one variants (see
  --    colors/darker.lua). DiffAdd/DiffDelete/DiffText are tokyonight's own
  --    0.25/0.25 blends and read fine as-is - left untouched.
  local Util = require("atom-one.util")
  local ty_colors = require("tokyonight.colors").setup({ style = "night" })
  vim.api.nvim_set_hl(0, "DiffChange", { bg = Util.blend(ty_colors.blue7, 0.35, ty_colors.bg) })

  vim.g.colors_name = "atom-one-tokyonight"
end

return M
