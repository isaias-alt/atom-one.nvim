-- LSP semantic token mapping (`@lsp.type.*` / `@lsp.typemod.*`).
--
-- `semanticTokenColors` in the upstream Binaryify/OneDark-Pro VS Code theme
-- is sparse (10 entries) because VS Code lets unmatched semantic tokens
-- fall through to the TextMate/tokenColors result. Neovim has no such
-- fallthrough between semantic tokens and Treesitter, so most entries here
-- link straight to the equivalent groups/treesitter.lua capture (same
-- mapping the tokenColors scope would have produced) - genuine ground
-- truth from `semanticTokenColors` is called out explicitly below.
--
-- `@lsp.type.variable` is intentionally empty: without it, plain `let x`
-- declarations (semantic type "variable", no modifiers) would double-apply
-- on top of Treesitter's `@variable`, which is redundant, not wrong - but
-- leaving it empty means Treesitter's styling always wins for the common
-- case, matching how every other capture here is meant to be a fallback,
-- not an override.

local M = {}

---@param c atom-one.Palette
---@param opts atom-one.Config
function M.get(c, opts)
  -- stylua: ignore
  return {
    ["@lsp.type.boolean"]                      = "@boolean",
    ["@lsp.type.builtinType"]                  = "@type.builtin",
    ["@lsp.type.class"]                        = "@type",
    ["@lsp.type.comment"]                      = "@comment",
    ["@lsp.type.decorator"]                    = "@attribute",
    ["@lsp.type.deriveHelper"]                 = "@attribute",
    ["@lsp.type.enum"]                         = "@type",
    ["@lsp.type.enumMember"]                   = { fg = c.cyan }, -- semanticTokenColors: enumMember
    ["@lsp.type.escapeSequence"]               = "@string.escape",
    ["@lsp.type.event"]                        = "@type",
    ["@lsp.type.formatSpecifier"]              = "@punctuation.special",
    ["@lsp.type.generic"]                      = "@variable",
    ["@lsp.type.interface"]                    = "@type",
    ["@lsp.type.keyword"]                      = "@keyword",
    ["@lsp.type.lifetime"]                     = { fg = c.fg }, -- storage.modifier.lifetime.rust (unstyled in source)
    ["@lsp.type.macro"]                        = { fg = c.orange }, -- semanticTokenColors: macro
    ["@lsp.type.method"]                       = "@function.method",
    ["@lsp.type.modifier"]                     = "@keyword.modifier",
    ["@lsp.type.namespace"]                    = "@module",
    ["@lsp.type.number"]                       = "@number",
    ["@lsp.type.operator"]                     = "@operator",
    ["@lsp.type.parameter"]                    = "@variable.parameter",
    ["@lsp.type.property"]                     = "@property",
    ["@lsp.type.regexp"]                       = "@string.regexp",
    ["@lsp.type.selfKeyword"]                  = "@variable.builtin",
    ["@lsp.type.selfTypeKeyword"]              = "@variable.builtin",
    ["@lsp.type.string"]                       = "@string",
    ["@lsp.type.struct"]                       = "@type",
    ["@lsp.type.type"]                         = "@type",
    ["@lsp.type.typeAlias"]                    = "@type.definition",
    ["@lsp.type.unresolvedReference"]          = { undercurl = true, sp = c.error },
    ["@lsp.type.variable"]                     = {}, -- see file header: defer to Treesitter's @variable

    ["@lsp.typemod.class.defaultLibrary"]      = "@type.builtin",
    ["@lsp.typemod.enum.defaultLibrary"]       = "@type.builtin",
    ["@lsp.typemod.enumMember.defaultLibrary"] = "@constant.builtin",
    ["@lsp.typemod.function.defaultLibrary"]   = "@function.builtin",
    ["@lsp.typemod.keyword.async"]             = "@keyword.coroutine",
    ["@lsp.typemod.keyword.injected"]          = "@keyword",
    ["@lsp.typemod.macro.defaultLibrary"]      = "@function.builtin",
    ["@lsp.typemod.method.defaultLibrary"]     = "@function.builtin",
    ["@lsp.typemod.operator.injected"]         = "@operator",
    ["@lsp.typemod.operator.overload"]         = { fg = c.magenta }, -- semanticTokenColors: memberOperatorOverload
    ["@lsp.typemod.property.readonly"]         = { fg = c.orange }, -- semanticTokenColors: variable.constant
    ["@lsp.typemod.string.injected"]           = "@string",
    ["@lsp.typemod.struct.defaultLibrary"]     = "@type.builtin",
    ["@lsp.typemod.type.defaultLibrary"]       = "@type.builtin",
    ["@lsp.typemod.typeAlias.defaultLibrary"]  = "@type.builtin",
    ["@lsp.typemod.variable.callable"]         = "@function",
    ["@lsp.typemod.variable.constant"]         = { fg = c.orange }, -- semanticTokenColors: variable.constant
    ["@lsp.typemod.variable.defaultLibrary"]   = { fg = c.yellow }, -- semanticTokenColors: variable.defaultLibrary
    ["@lsp.typemod.variable.injected"]         = "@variable",
    ["@lsp.typemod.variable.readonly"]         = "@lsp.typemod.variable.constant",
    ["@lsp.typemod.variable.static"]           = "@constant",
  }
end

return M
