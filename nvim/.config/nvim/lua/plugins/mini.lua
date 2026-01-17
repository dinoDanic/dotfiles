return {
  "echasnovski/mini.nvim",
  version = "*",
  config = function()
    require("mini.comment").setup()
    require("mini.statusline").setup()
    require("mini.tabline").setup()
    require("mini.icons").setup({
      -- Icon style: 'glyph' or 'ascii'
      style = 'ascii',
    })
    MiniIcons.mock_nvim_web_devicons()
    require("mini.files").setup()
    require("mini.bufremove").setup()
    require("mini.extra").setup()
  end,
}
