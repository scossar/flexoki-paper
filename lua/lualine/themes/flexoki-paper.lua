local c = require("flexoki-paper").palette

local body = {
  b = { fg = c.ink, bg = c.base150 },
  c = { fg = c.base700, bg = c.base50 },
}

local function mode(color)
  return {
    a = { fg = c.paper, bg = color, gui = "bold" },
    b = vim.deepcopy(body.b),
    c = vim.deepcopy(body.c),
  }
end

return {
  normal = mode(c.blue),
  insert = mode(c.green),
  visual = mode(c.purple),
  replace = mode(c.red),
  command = mode(c.orange),
  terminal = mode(c.cyan),
  inactive = {
    a = { fg = c.base600, bg = c.base50 },
    b = { fg = c.base600, bg = c.base50 },
    c = { fg = c.base600, bg = c.base50 },
  },
}
