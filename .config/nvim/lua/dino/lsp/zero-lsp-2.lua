local lsp = require('lsp-zero').preset({
  name = 'minimal',
  set_lsp_keymaps = false,
  manage_nvim_cmp = true,
  suggest_lsp_servers = true,
})

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

lsp.setup()

-- TODO: TSserver dosent want to load so im using this keymaps
local bufopts = { noremap = true, silent = true }
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)

lsp.setup_nvim_cmp({
  -- mapping = cmp_mappings,
  sources = {
    { name = 'nvim_lsp', keyword_length = 1 },
    { name = 'luasnip',  keyword_length = 2 },
    { name = 'path' },
    { name = 'buffer',   keyword_length = 3 },
  },
})

lsp.configure('tsserver', {
  on_attach = function(client, bufnr)
  end,
  settings = {
    completions = {
      completeFunctionCalls = false
    }
  }
})


-- yank highlight
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
