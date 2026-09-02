# atom-one.nvim - spec

Read this before writing any code. It's the single source of truth for scope
and architecture; everything under `docs/reference/` is supporting material,
not instructions.

## Overview

A Neovim colorscheme implementing all 5 official variants of **One Dark
Pro**, faithfully matching the original VS Code extension
([Binaryify/OneDark-Pro](https://github.com/Binaryify/OneDark-Pro)) rather
than approximating it. The existing `olimorris/onedarkpro.nvim` was tried
first and didn't match closely enough - its palette and highlight-group
mapping diverge from the VS Code source, which is the actual reference point
that matters here. Full detail on the origin story is not necessary for
implementation; the point is: **the VS Code JSON files in
`docs/reference/onedark-pro-vscode/` are ground truth. When in doubt, match
those, not memory of what "One Dark" usually looks like.**

## The 5 variants

| Variant name | VS Code source file | `editor.background` | `editor.foreground` |
|---|---|---|---|
| `atom-one` (default) | `OneDark-Pro.json` | `#282c34` | `#abb2bf` |
| `atom-one-darker` | `OneDark-Pro-darker.json` | `#23272e` | `#abb2bf` |
| `atom-one-flat` | `OneDark-Pro-flat.json` | `#282c34` | `#abb2bf` |
| `atom-one-mix` | `OneDark-Pro-mix.json` | `#282c34` | `#abb2bf` |
| `atom-one-night-flat` | `OneDark-Pro-night-flat.json` | `#16191d` | `#abb2bf` |

**Important**: `flat`, `mix`, and the base theme share the same
`editor.background`/`editor.foreground`/terminal ANSI colors - the
differences between them live in `tokenColors` (syntax highlighting) and
`semanticTokenColors`, not the UI chrome. Confirmed by comparing entry
counts: base has 275 `tokenColors` entries, darker/night-flat have 272 each,
flat/mix have 277 each - they are **not** identical. Do not assume flat/mix
are visual no-ops relative to the base theme; actually diff their
`tokenColors` arrays (by `scope`) when building the Treesitter mapping for
each, don't just reuse the base variant's mapping for all three.

All 5 variants share the exact same terminal ANSI 16-color palette:

```
ansi:    #3f4451 #e05561 #8cc265 #d18f52 #4aa5f0 #c162de #42b3c2 #d7dae0
brights: #4f5666 #ff616e #a5e075 #f0a45d #4dc4ff #de73ff #4cd1e0 #e6e6e6
```
(black, red, green, yellow, blue, magenta, cyan, white - in order)

## In scope (v1)

- Core editor UI groups: `Normal`, `CursorLine`, `Visual`, `Search`,
  `Pmenu`, diagnostics (`DiagnosticError` etc.), diffs, folds, statusline -
  the baseline every colorscheme needs regardless of plugins installed.
- Treesitter capture groups (`@variable`, `@keyword`, `@string`,
  `@function`, `@type`, `@tag`, `@punctuation.*`, etc.)
- LSP semantic tokens (`@lsp.type.*`, `@lsp.mod.*`)
- Terminal ANSI colors (`g:terminal_color_0`..`15`, for `:terminal` and
  anything that shells out)

## Non-goals (v1)

No plugin-specific highlight groups: telescope, gitsigns, cmp, snacks,
lualine, bufferline, which-key, dashboard, neo-tree, trouble, noice, mini.*,
etc. `docs/reference/tokyonight.nvim/` and
`docs/reference/solarized-osaka.nvim/` both have a `groups/` directory with
one file per integration - everything in there beyond `base.lua`/
`editor.lua`, `treesitter.lua`, and `semantic_tokens.lua` is exactly what
we're skipping. Add plugin integrations later, one at a time, only for
plugins actually in use (see the dotfiles repo's `home/.config/nvim/` for
what that currently is - snacks.nvim, oil.nvim, neogit/gitsigns,
which-key.nvim - but don't preemptively build for these either; wait until
asked).

Also not in scope for v1: the terminal-app export files both reference repos
have (`extra/kitty.lua`, `extra/wezterm.lua`, `extra/alacritty.lua`, etc.) -
not needed, WezTerm config is handled directly in the dotfiles repo.

## Architecture

Modeled directly on `tokyonight.nvim` and `solarized-osaka.nvim` (near-identical
structure between the two), trimmed to the in-scope groups above:

```
lua/atom-one/
  init.lua              -- setup(), _load(), public API
  config.lua             -- options + defaults (style/variant selection)
  theme.lua               -- assembles palette + all group modules into one highlight table
  util.lua                -- color math (blend/lighten/darken) if needed
  colors/
    onedark.lua            -- base variant palette
    darker.lua
    flat.lua
    mix.lua
    night_flat.lua
  groups/
    init.lua                -- combines the group modules below
    base.lua                 -- core editor UI groups
    treesitter.lua
    semantic_tokens.lua
colors/
  atom-one.lua              -- thin entrypoint: require("atom-one")._load("onedark")
  atom-one-darker.lua
  atom-one-flat.lua
  atom-one-mix.lua
  atom-one-night-flat.lua
```

Each `colors/atom-one-*.lua` entrypoint is a one-liner, same pattern as
`docs/reference/solarized-osaka.nvim/colors_entrypoint.lua` and
`docs/reference/tokyonight.nvim/colors_entrypoint.lua`.

## Reference material (`docs/reference/`)

- `onedark-pro-vscode/*.json` - the 5 actual VS Code theme files, unmodified.
  This is the palette and token-color **ground truth**. Parse `colors` for
  UI/terminal hex, `tokenColors` (TextMate scopes) for syntax colors, and
  `semanticTokenColors` for LSP semantic token colors. Map TextMate scopes
  to Treesitter captures and LSP semantic token types by hand - there's no
  automatic translation, this is the actual implementation work.
- `tokyonight.nvim/*.lua` and `solarized-osaka.nvim/*.lua` - a curated
  subset of each repo (entrypoint, config, theme assembler, util, one
  palette file, and the `base`/`editor`, `treesitter`, `semantic_tokens`
  group files) kept **for architectural reference only** - how they
  structure the palette table, how `theme.lua` merges group modules, what a
  `treesitter.lua`/`semantic_tokens.lua` group file actually looks like in
  practice. Both repos are Apache-2.0: don't copy code verbatim into
  `atom-one.nvim`, use them to understand the pattern and write our own.

## Open decisions

- License: not chosen yet (leaning MIT). Add a `LICENSE` file before the
  first public push, not before.
- Not pushed to GitHub yet - this is local-only until the user decides to
  publish.
