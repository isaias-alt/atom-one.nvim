-- TextMate scope -> Treesitter capture mapping.
--
-- This is hand-mapped from the generic (language-agnostic) tokenColors
-- entries in the upstream Binaryify/OneDark-Pro VS Code theme - there is
-- no mechanical scope->capture translation. Every non-obvious choice below
-- cites the TextMate scope(s) it's derived from so it can be checked
-- against that theme's JSON directly.
--
-- Where a capture's color exactly matches a classic vim group already
-- defined in groups/base.lua, it links to that group instead of repeating
-- the hex (same pattern as tokyonight/solarized-osaka's treesitter.lua).
--
-- Two deliberate, non-obvious splits fall out of the JSON that are worth
-- flagging up front:
--   - @operator (symbolic: + - == && etc.) is cyan, but @keyword.operator
--     (word-form: new/typeof/instanceof/in/of/is/keyof/delete/void) is
--     magenta, matching `keyword.operator.arithmetic` et al (cyan, rows
--     used by e.g. JS/Python) vs. `keyword.operator.expression.*` (magenta).
--   - Plain identifiers ARE colored (red), not left at the default
--     foreground: that's `variable.other.readwrite` or
--     `variable.parameter.function.js/ts` etc., not a bare `variable`
--     fallback - it's one of the theme's recognizable traits.

local M = {}

---@param c atom-one.Palette
---@param opts atom-one.Config
function M.get(c, opts)
  -- stylua: ignore
  return {
    ["@none"]                        = {},

    -- Comments
    ["@comment"]                     = "Comment",
    ["@comment.documentation"]       = "Comment", -- comment.block.documentation (italic, inherits Comments fg)
    ["@comment.error"]               = { fg = c.error },
    ["@comment.warning"]             = { fg = c.warning },
    ["@comment.hint"]                = { fg = c.hint },
    ["@comment.info"]                = { fg = c.info },
    ["@comment.note"]                = { fg = c.hint },
    ["@comment.todo"]                = "Todo",

    -- Constants / literals
    ["@constant"]                    = "Constant", -- bare `constant`
    ["@constant.builtin"]            = { fg = c.orange }, -- support.constant.*
    ["@constant.macro"]              = "Constant",
    ["@boolean"]                     = "Boolean",
    ["@number"]                      = "Number", -- constant.numeric
    ["@number.float"]                = "Number",

    -- Strings
    ["@string"]                      = "String", -- bare `string`
    ["@string.documentation"]        = "String",
    ["@string.regexp"]               = { fg = c.red }, -- string.regexp (last-defined entry wins, see JSON)
    ["@string.escape"]               = "SpecialChar", -- constant.character.escape
    ["@string.special"]              = "Special",
    ["@string.special.symbol"]       = { fg = c.cyan }, -- constant.language.symbol.* (ruby/elixir/clojure)
    ["@string.special.url"]          = { fg = c.blue, underline = true }, -- string.other.link.title.markdown
    ["@string.special.path"]         = "String",
    ["@character"]                   = "Character",
    ["@character.special"]           = "SpecialChar", -- constant.character.entity

    -- Types
    ["@type"]                        = "Type", -- entity.name.type
    ["@type.builtin"]                = "Type", -- support.type.primitive
    ["@type.definition"]             = "Type",
    ["@type.qualifier"]              = "StorageClass", -- storage.type.* modifiers
    ["@attribute"]                   = { fg = c.orange }, -- entity.other.attribute-name
    ["@attribute.builtin"]           = "@attribute",
    ["@property"]                    = { fg = c.red }, -- variable.other.readwrite / meta.object-literal.key
    ["@constructor"]                 = "Type", -- grouped with class identifiers, not the `new`/`class` keyword

    -- Functions
    ["@function"]                    = "Function", -- entity.name.function
    ["@function.builtin"]            = { fg = c.cyan }, -- support.function (generic; distinct from user functions)
    ["@function.macro"]              = "Function",
    ["@function.call"]               = "@function",
    ["@function.method"]             = "Function",
    ["@function.method.call"]        = "@function.method",

    -- Keywords
    ["@keyword"]                     = "Keyword", -- bare `keyword` / `keyword.control`
    ["@keyword.function"]            = "StorageClass", -- bare `storage` (the `function`/`def`/`fn` declarator)
    ["@keyword.type"]                = "StorageClass", -- bare `storage` (the `class`/`struct`/`interface` declarator)
    ["@keyword.modifier"]            = "StorageClass", -- bare `storage` (static/public/const/...)
    ["@keyword.coroutine"]           = "Keyword",
    ["@keyword.conditional"]         = "Conditional",
    ["@keyword.conditional.ternary"]  = { fg = c.magenta }, -- keyword.operator.ternary
    ["@keyword.repeat"]              = "Repeat",
    ["@keyword.return"]              = "Keyword",
    ["@keyword.exception"]           = "Exception",
    ["@keyword.debug"]               = "Debug",
    ["@keyword.import"]              = { fg = c.blue }, -- keyword.operator.expression.import
    ["@keyword.export"]              = "@keyword.import",
    ["@keyword.directive"]           = "PreProc",
    ["@keyword.directive.define"]    = "Define",
    ["@keyword.operator"]            = { fg = c.magenta }, -- keyword.operator.expression.{new,typeof,instanceof,in,of,is,keyof,delete,void}
    ["@operator"]                    = "Operator", -- keyword.operator.{arithmetic,comparison,logical,bitwise,assignment}

    -- Variables
    ["@variable"]                   = "Identifier", -- variable.other.readwrite
    ["@variable.builtin"]           = { fg = c.yellow }, -- variable.language (this/self/super)
    ["@variable.parameter"]         = { fg = c.red }, -- variable.parameter.function.{js,ts,coffee,latex,...}
    ["@variable.parameter.builtin"] = "@variable.parameter",
    ["@variable.member"]            = "@property",
    ["@module"]                     = "Type", -- entity.name.namespace / entity.name.type.module (yellow)
    ["@module.builtin"]             = "@variable.builtin",
    ["@label"]                      = "Label", -- entity.name.label

    -- Punctuation
    ["@punctuation.delimiter"]      = { fg = c.fg }, -- punctuation.separator.* (unstyled: inherits editor.foreground)
    ["@punctuation.bracket"]        = { fg = c.fg },
    ["@punctuation.special"]        = { fg = c.magenta }, -- punctuation.definition.template-expression.* (`${ }`)

    -- Markup (markdown/asciidoc)
    ["@markup.strong"]              = { fg = c.orange, bold = true }, -- markup.bold
    ["@markup.italic"]              = { fg = c.magenta, italic = true }, -- markup.italic
    ["@markup.strikethrough"]       = { fg = c.comment, strikethrough = true },
    ["@markup.underline"]           = { underline = true },
    ["@markup.heading"]             = { fg = c.red, bold = true }, -- markup.heading
    ["@markup.quote"]               = { fg = c.gray }, -- markup.quote.markdown
    ["@markup.math"]                = "Special",
    ["@markup.link"]                = { fg = c.blue, underline = true },
    ["@markup.link.label"]          = { fg = c.blue }, -- string.other.link.title.markdown
    ["@markup.link.url"]            = { fg = c.magenta, underline = true }, -- markup.underline.link.markdown
    ["@markup.raw"]                 = { fg = c.green }, -- markup.inline.raw.markdown
    ["@markup.raw.block"]           = "@markup.raw",
    ["@markup.list"]                = { fg = c.red }, -- beginning.punctuation.definition.list.markdown
    ["@markup.list.checked"]        = { fg = c.green },
    ["@markup.list.unchecked"]      = { fg = c.fg_gutter },

    -- Diff
    ["@diff.plus"]                  = "DiffAdd",
    ["@diff.minus"]                 = "DiffDelete",
    ["@diff.delta"]                 = "DiffChange",

    -- Tags (HTML/JSX/XML)
    ["@tag"]                        = "Tag", -- entity.name.tag
    ["@tag.attribute"]              = { fg = c.orange }, -- entity.other.attribute-name(.html)
    ["@tag.delimiter"]              = { fg = c.fg },
  }
end

return M
