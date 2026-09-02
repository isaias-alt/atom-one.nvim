local M = {}

M.setup = function(...)
  return require("atom-one.config").setup(...)
end

--- Entrypoint for the thin colors/atom-one-*.lua scripts.
---@param variant "onedark"|"darker"|"flat"|"mix"|"night_flat"
function M._load(variant)
  M.load({ variant = variant })
end

---@param opts atom-one.Config|nil
function M.load(opts)
  if opts then
    require("atom-one.config").extend(opts)
  end
  require("atom-one.theme").setup()
end

return M
