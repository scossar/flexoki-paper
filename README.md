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
