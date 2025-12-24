-- Completion navigation (mini.completion)
vim.keymap.set("i", "<C-j>", function()
  return vim.fn.pumvisible() == 1 and "<C-n>" or "<C-j>"
end, { expr = true, silent = true })

vim.keymap.set("i", "<C-k>", function()
  return vim.fn.pumvisible() == 1 and "<C-p>" or "<C-k>"
end, { expr = true, silent = true })

vim.keymap.set("i", "<CR>", function()
  if vim.fn.pumvisible() == 1 then
    return "<C-n><C-y>"
  end
  return "<CR>"
end, { expr = true, silent = true })

return {
  "echasnovski/mini.nvim",
  version = "*",
  config = function()
    require("mini.comment").setup()
    require("mini.pairs").setup()
    require("mini.statusline").setup()
    require("mini.completion").setup()
    require("mini.tabline").setup()
    require("mini.icons").setup()
    require("mini.bufremove").setup()
    require("mini.pick").setup({
      mappings = {
        move_down   = "<C-j>",
        move_up     = "<C-k>",
      },
    })
    require("mini.extra").setup()
  end,
}


