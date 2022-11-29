require("bufferline").setup{
  options = {
    separator_style = "thick",
    offsets = {
        {
          filetype = "NvimTree",
          text = "",
          highlight = "Directory",
          separator = false -- use a "true" to enable the default, or set your own character
        }
     },

    buffer_close_icon = '',
    modified_icon = '●',
    close_icon = '',
    show_buffer_close_icons = false,
  }
}

