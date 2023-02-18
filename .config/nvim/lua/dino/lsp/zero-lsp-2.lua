local lsp = require('lsp-zero').preset({
  name = 'minimal',
  set_lsp_keymaps = true,
  manage_nvim_cmp = true,
  suggest_lsp_servers = true,
})

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

lsp.setup()

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
    print('hello tsserver')
  end,
  settings = {
    completions = {
      completeFunctionCalls = false
    }
  }
})
