return {
  "echasnovski/mini.nvim",
  version = "*",
  config = function()
    require("mini.comment").setup()
    require("mini.statusline").setup()
    require("mini.tabline").setup()
    require("mini.diff").setup()
    require("mini.icons").setup()
    require("mini.bufremove").setup()
    require("mini.pick").setup({
      mappings = {
        move_down = "<C-j>",
        move_up   = "<C-k>",
      },
    })
    require("mini.extra").setup()
  end,
}
