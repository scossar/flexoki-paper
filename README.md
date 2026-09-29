# flexoki-paper

A light Neovim colorscheme built from [Flexoki](https://stephango.com/flexoki).
It uses warm paper and ink colors, with highlights for Tree-sitter, LSP,
diagnostics, and common Neovim plugins.

The primary target is LazyVim as used with Omarchy. A true-color terminal is
required; loading the theme enables `termguicolors` and sets `background=light`.

## Tested environment

Reviewed with Neovim **0.12.5**, LazyVim **`999700997f72227187d49d8b92667183dc7fc809`**,
and lazy.nvim **`85c7ff3711b730b4030d03144f6db6375044ae82`**. The tested configuration
includes personal LazyVim extras, including fzf-lua, Neo-tree, DAP, and language
extras. It is not an untouched stock Omarchy installation. These versions describe
the tested baseline, rather than a minimum-version guarantee.

## Install

With [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "scossar/flexoki-paper",
  lazy = false,
  priority = 1000,
  opts = {},
  config = function(_, opts)
    require("flexoki-paper").setup(opts)
    vim.cmd.colorscheme("flexoki-paper")
  end,
}
```

Or add the repository to Neovim's `runtimepath` and run
`:colorscheme flexoki-paper`.

The theme has no plugin dependencies. `require("flexoki-paper").palette`
exposes its color table for custom highlights.

## LazyVim

In a file under `lua/plugins/`, use:

```lua
return {
  { "scossar/flexoki-paper", lazy = false, priority = 1000 },
  { "LazyVim/LazyVim", opts = { colorscheme = "flexoki-paper" } },
}
```

The theme styles LazyVim's editor, diagnostics, Tree-sitter captures, semantic
tokens, and common plugin surfaces. Explicit integrations cover fzf-lua,
blink.cmp, Snacks, bufferline, lualine, Neo-tree, Trouble, Noice, render-markdown,
Gitsigns, DAP and dap-ui, grug-far, Flash, and WhichKey. Plugins that use standard
Neovim highlight groups inherit the same palette.

### Omarchy

Check your existing `lua/plugins/theme.lua` before adding a theme specification.
Omarchy may make this file a symlink to its currently selected desktop theme's
`neovim.lua`. Editing that symlink edits the selected desktop theme's file.

To follow Omarchy's desktop theme selection, put the LazyVim specification above
in the `neovim.lua` of your custom Omarchy theme. To keep flexoki-paper selected
independently, put it in `lua/plugins/zz-flexoki-paper.lua`, which is imported
after `theme.lua` by lazy.nvim. Avoid other later specifications that also set
`LazyVim/LazyVim.opts.colorscheme`. Omarchy's hot-reload integration can still
apply the desktop theme during a running session; reapply
`:colorscheme flexoki-paper` or restart Neovim afterward.

Also check for `plugin/after/transparency.lua` or other transparency overrides.
When sourced, these can remove the paper and floating-window backgrounds after
the colorscheme has applied. Disable those overrides for the intended opaque
appearance. Neither transparency overrides nor Omarchy's hot-reload integration
is required by this theme.

## Customize highlights

For standalone lazy.nvim, use this complete specification:

```lua
{
  "scossar/flexoki-paper",
  lazy = false,
  priority = 1000,
  opts = {
    highlights = {
      Comment = { fg = "#575653", italic = false },
      ["@function"] = { fg = "#205EA6" },
    },
  },
  config = function(_, opts)
    require("flexoki-paper").setup(opts)
    vim.cmd.colorscheme("flexoki-paper")
  end,
}
```

For LazyVim, add the same `opts` table to the theme entry in the LazyVim example.
Leave activation to `LazyVim/LazyVim.opts.colorscheme`; lazy.nvim calls the
theme's `setup(opts)` automatically when there is no custom `config` callback.

Without a plugin manager, call `require("flexoki-paper").setup({ highlights =
{ Comment = { italic = false } } })` before `:colorscheme flexoki-paper`.

To change options in a running session, call `setup()` with the new options and
run `:colorscheme flexoki-paper` again. Each `setup()` call replaces the previous
options. Property overrides preserve the group's other attributes, resolving
links and overrides on linked targets first. An explicit `link` override replaces
the definition with that link; other properties alongside `link` are ignored.

The terminal palette applies to newly opened embedded terminals. Neovim reads
these colors when a terminal opens, so reopen existing terminals after switching
colorschemes to use the new palette.

## Development

Run the headless regression checks from the repository root:

```sh
NVIM_LOG_FILE=/tmp/flexoki-paper-test.log nvim --clean -i NONE -n --headless -l tests/theme.lua
```

## License

[MIT](LICENSE). The palette is derived from [Flexoki](https://stephango.com/flexoki)
by Steph Ango, also distributed under the MIT license.
