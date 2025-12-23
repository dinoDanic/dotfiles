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
    require("mini.pick").setup()
    require("mini.extra").setup()
  end,
}
