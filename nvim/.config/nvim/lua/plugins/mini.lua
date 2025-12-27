return {
  "echasnovski/mini.nvim",
  version = "*",
  config = function()
    require("mini.comment").setup()
    require("mini.statusline").setup()
    require("mini.tabline").setup()
    require("mini.icons").setup()
    require("mini.bufremove").setup()
    require("mini.extra").setup()
  end,
}
