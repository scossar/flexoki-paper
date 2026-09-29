# flexoki-paper

A light Neovim colorscheme built from [Flexoki](https://stephango.com/flexoki).
It uses warm paper and ink colors, with highlights for Tree-sitter, LSP,
diagnostics, and common Neovim plugins.

## Install

With [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "scossar/flexoki-paper",
  lazy = false,
  priority = 1000,
  config = function()
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

## Customize highlights

Call `setup()` before loading the colorscheme, or pass `opts` to lazy.nvim:

```lua
{
  "scossar/flexoki-paper",
  lazy = false,
  priority = 1000,
  opts = {
    highlights = {
      Comment = { fg = "#575653", italic = false },
    },
  },
}
```

Run `:colorscheme flexoki-paper` again after changing the options in a running
session. Overrides replace only the properties supplied for each group.
