# atom-one.nvim

A faithful Neovim port of the 5 official **One Dark Pro** variants (the theme
that started life as Atom's built-in "One Dark", later extended by
[Binaryify/OneDark-Pro](https://github.com/Binaryify/OneDark-Pro) for VS
Code): `OneDark Pro`, `Darker`, `Flat`, `Mix`, and `Night Flat`.

This is **not** a fork of, and does not compete with,
[`olimorris/onedarkpro.nvim`](https://github.com/olimorris/onedarkpro.nvim) -
that plugin already exists, is actively maintained, and covers a much wider
surface (many more plugin integrations). This project exists because its
palette doesn't match the original VS Code extension closely enough for what
I wanted. Full rationale and scope: [`docs/SPEC.md`](docs/SPEC.md).

## Status

Pre-implementation. This repo currently holds the spec and reference
material for the initial implementation pass - no plugin code yet.

## Planned installation (lazy.nvim)

```lua
{
  "isaias-alt/atom-one.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("atom-one")
  end,
}
```

Variant-specific colorschemes will also be available directly, e.g.
`:colorscheme atom-one-darker`, `:colorscheme atom-one-night-flat`.

## Scope

Treesitter highlight groups, LSP semantic tokens, and terminal ANSI colors,
for all 5 variants. No plugin-specific integrations (telescope, gitsigns,
cmp, lualine, etc.) in v1 - see [`docs/SPEC.md`](docs/SPEC.md#non-goals-v1)
for the reasoning.

## Credits

- Palette source: [Binaryify/OneDark-Pro](https://github.com/Binaryify/OneDark-Pro) (MIT)
- Architecture modeled after [folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim) (Apache-2.0)
  and [craftzdog/solarized-osaka.nvim](https://github.com/craftzdog/solarized-osaka.nvim) (Apache-2.0)

## License

TBD (leaning MIT, to match the surrounding Neovim colorscheme ecosystem) -
not yet added, decide before the first public push.
