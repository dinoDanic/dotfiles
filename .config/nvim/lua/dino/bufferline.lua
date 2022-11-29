require("bufferline").setup{
  options = {
    diagnostics  = "nvim_lsp",
    offsets = {
        {
          filetype = "NvimTree",
          text = "HC",
          highlight = "Directory",
          separator = false -- use a "true" to enable the default, or set your own character
        }
     },
    buffer_close_icon = '',
    modified_icon = '●',
    close_icon = '',
    show_buffer_close_icons = false,
    show_lose_icons = false,
  }
}

