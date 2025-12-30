return {
  "echasnovski/mini.nvim",
  version = "*",
  config = function()
    require("mini.comment").setup()
    require("mini.statusline").setup()
    require("mini.tabline").setup()
    require("mini.icons").setup()
    require("mini.files").setup()
    -- require("mini.pick").setup()
    require("mini.bufremove").setup()
    require("mini.extra").setup()
  end,
}
