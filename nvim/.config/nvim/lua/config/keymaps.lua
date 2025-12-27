-- ============================================================================
-- Requires
-- ============================================================================
local bufremove = require("mini.bufremove")

-- ============================================================================
-- Basics
-- ============================================================================
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>h", "<cmd>nohlsearch<CR>")
vim.keymap.set("i", "jj", "<Esc>")

-- ============================================================================
-- Window navigation
-- ============================================================================
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Window left" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Window right" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Window down" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Window up" })

-- ============================================================================
-- Buffer navigation
-- ============================================================================
vim.keymap.set("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Prev buffer" })

-- Close current buffer (layout-safe)
vim.keymap.set("n", "<leader>c", function()
  bufremove.delete(0)
end, { desc = "Close buffer" })

-- Close buffers to the left
vim.keymap.set("n", "<leader>bh", function()
  local cur = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf < cur and vim.bo[buf].buflisted then
      bufremove.delete(buf, false)
    end
  end
end, { desc = "Close buffers to the left" })

-- Close buffers to the right
vim.keymap.set("n", "<leader>bl", function()
  local cur = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf > cur and vim.bo[buf].buflisted then
      bufremove.delete(buf, false)
    end
  end
end, { desc = "Close buffers to the right" })

-- ============================================================================
-- Diagnostics
-- ============================================================================
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Diagnostics" })

-- ============================================================================
-- Files
-- ============================================================================
vim.keymap.set("n", "<leader>q", "<cmd>q!<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>w", "<cmd>w!<CR>", { desc = "Write" })
vim.keymap.set("n", "<leader>.", "<cmd>luafile %<CR>", { desc = "Source file" })

vim.keymap.set("n", "<leader>e", "<cmd>Ex<CR>", { desc = "NetRW" })

vim.keymap.set("n", "<leader>e", function()
  local file = vim.fn.expand("%:t")
  local dir = vim.fn.expand("%:p:h")

  vim.cmd("Explore " .. dir)

  vim.schedule(function()
    vim.fn.search("\\V" .. file)
  end)
end, { desc = "Netrw (file dir, cursor on file)" })

-- ============================================================================
-- Editing
-- ============================================================================
vim.keymap.set("n", "x", '"_x', { desc = "Delete without yank" })

-- ============================================================================
-- LSP (global, non-attach)
-- ============================================================================
vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code action" })
vim.keymap.set("n", "<leader>lj", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set("n", "<leader>lk", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
vim.keymap.set("n", "<leader>lf", function()
  vim.lsp.buf.format({ async = true })
end, { desc = "Format" })
vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename" })

-- ============================================================================
-- Comments (mini.comment)
-- ============================================================================
-- vim.keymap.set("n", "<leader>/", "<Plug>(comment_toggle_linewise_current)", { desc = "Toggle comment" })
-- vim.keymap.set("v", "<leader>/", "<Plug>(comment_toggle_linewise_visual)", { desc = "Toggle comment" })
vim.keymap.set("n", "<leader>/", "gcc", {
  desc = "Toggle comment (gcc)",
  remap = true,
})
vim.keymap.set("v", "<leader>/", "gc", {
  desc = "Toggle comment",
  remap = true,
})

-- ============================================================================
-- Utilities
-- ============================================================================
local function kebab_to_camel(str)
  return str:gsub("%-([a-z])", function(c) return c:upper() end)
end

vim.keymap.set("n", "<leader>sc", function()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  for i, line in ipairs(lines) do
    lines[i] = line:gsub("([%w]+%-[%w%-]+)", kebab_to_camel)
  end
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end, { desc = "kebab-case → camelCase" })
