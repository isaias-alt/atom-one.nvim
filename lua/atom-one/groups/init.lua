local Util = require("atom-one.util")

local M = {}

-- v1 scope only: no plugin-specific group modules - so unlike
-- tokyonight/solarized-osaka's groups/init.lua, there's no plugin-detection
-- gating here, just a fixed merge.
local MODULES = { "base", "treesitter", "semantic_tokens" }

---@param colors atom-one.Palette
---@param opts atom-one.Config
function M.setup(colors, opts)
  local ret = {}

  for _, name in ipairs(MODULES) do
    for group, hl in pairs(require("atom-one.groups." .. name).get(colors, opts)) do
      ret[group] = hl
    end
  end

  Util.resolve(ret)
  opts.on_highlights(ret, colors)

  return ret
end

return M
