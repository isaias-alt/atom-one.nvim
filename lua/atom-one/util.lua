local M = {}

--- Alpha-composites a foreground color over a background color, the same
--- math VS Code uses to resolve an 8-digit (RGBA) theme color onto a solid
--- one. Used to turn ground-truth alpha colors from the VS Code JSON
--- (selection, search, word-highlight, diff backgrounds) into the opaque
--- hex values `nvim_set_hl` requires.
---@param fg string hex color, e.g. "#61afef"
---@param alpha number 0..1, 0 keeps bg, 1 keeps fg
---@param bg string hex color
---@return string
function M.blend(fg, alpha, bg)
  local function rgb(hex)
    return { tonumber(hex:sub(2, 3), 16), tonumber(hex:sub(4, 5), 16), tonumber(hex:sub(6, 7), 16) }
  end

  local f, b = rgb(fg), rgb(bg)
  local ret = {}
  for i = 1, 3 do
    local v = alpha * f[i] + (1 - alpha) * b[i]
    ret[i] = math.floor(math.min(math.max(v, 0), 255) + 0.5)
  end
  return string.format("#%02x%02x%02x", ret[1], ret[2], ret[3])
end

--- Flattens `hl.style = { italic = true, ... }` into the highlight table
--- itself, so group files can write `{ fg = c.red, style = opts.styles.x }`
--- without opts.styles.x leaking a nested `style` key into nvim_set_hl.
---@param groups table<string, vim.api.keyset.highlight|string>
function M.resolve(groups)
  for _, hl in pairs(groups) do
    if type(hl) == "table" and type(hl.style) == "table" then
      for k, v in pairs(hl.style) do
        hl[k] = v
      end
      hl.style = nil
    end
  end
  return groups
end

return M
