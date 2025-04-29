local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
  return
end

require("nvim-tree").setup({
  on_attach = on_attach,
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    -- mappings = {
    --   list = {
    --     { key = "l", action = "edit" },
    --     { key = "v", action = "vsplit" },
    --   },
    -- },
  },
  -- for project.nvim
  -- sync_root_with_cwd = true,
  -- respect_buf_cwd = true,
  -- for project.nvim
  update_focused_file = {
    enable = true,
    update_root = true
  },
  renderer = {
    root_folder_modifier = ":t",
    group_empty = false,
    icons = {
      git_placement = "signcolumn",
      show = {
        folder_arrow = false
      },
      glyphs = {
        default = "",
        symlink = "",
        folder = {
          arrow_open = "",
          arrow_closed = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
  filters = {
    dotfiles = false,
    exclude = {},
    custom = {},
  },
  git = {
    ignore = false,
  },
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
})
