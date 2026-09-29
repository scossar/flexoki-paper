vim.opt.rtp:prepend(vim.fn.getcwd())

local theme = require("flexoki-paper")
local function apply(opts)
  theme.setup(opts)
  vim.cmd.colorscheme("flexoki-paper")
end
local function hl(name)
  return vim.api.nvim_get_hl(0, { name = name, link = false })
end
local function color(hex)
  return tonumber(hex:sub(2), 16)
end

apply()
local baseline = vim.api.nvim_get_hl(0, {})
assert(vim.g.terminal_color_0 ~= vim.g.terminal_color_15, "ANSI black and bright white must differ")
assert(vim.g.terminal_color_0 == theme.palette.ink)
assert(vim.g.terminal_color_15 == theme.palette.paper)

apply({ highlights = {
  Comment = { fg = "#575653", italic = false },
  Function = { fg = "#123456", bold = true },
  ["@function"] = { italic = true },
  ["@function.call"] = { fg = "#654321" },
  DiagnosticError = { fg = "#234567" },
  DiagnosticSignError = { bold = true },
  Operator = { link = "Comment", fg = "#FFFFFF", bold = true },
  ["@operator"] = { italic = true },
  ["@lsp.type.enumMember"] = { bold = true },
  ReviewLinked = { link = "@function" },
  ReviewChained = { link = "ReviewLinked" },
  String = { link = "ReviewChained" },
} })
assert(hl("Comment").fg == color("#575653") and not hl("Comment").italic)
assert(hl("@function").fg == color("#123456"))
assert(hl("@function").bold and hl("@function").italic)
assert(hl("@function.call").fg == color("#654321") and hl("@function.call").bold)
assert(hl("DiagnosticSignError").fg == color("#234567") and hl("DiagnosticSignError").bold)
assert(hl("@operator").fg == color("#575653") and hl("@operator").italic and not hl("@operator").bold)
assert(hl("@lsp.type.enumMember").fg == color(theme.palette.yellow) and hl("@lsp.type.enumMember").bold)
assert(hl("String").fg == color("#123456") and hl("String").italic)
assert(vim.api.nvim_get_hl(0, { name = "String" }).link == "ReviewChained")

local customized = vim.api.nvim_get_hl(0, {})
vim.cmd.colorscheme("flexoki-paper")
assert(vim.deep_equal(customized, vim.api.nvim_get_hl(0, {})), "Reapplying must preserve overrides")
vim.cmd.colorscheme("habamax")
vim.cmd.colorscheme("flexoki-paper")
for name, spec in pairs(customized) do
  assert(vim.deep_equal(spec, vim.api.nvim_get_hl(0, { name = name })), "Switching changed " .. name)
end

apply()
for name, spec in pairs(baseline) do
  assert(vim.deep_equal(spec, vim.api.nvim_get_hl(0, { name = name })), "Reset changed " .. name)
end
print("flexoki-paper regression checks passed")
