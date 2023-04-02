local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

vim.opt.signcolumn = 'yes'

local lsp = require('lsp-zero')
lsp.preset('recommended')

lsp.ensure_installed({
  'tsserver',
  'eslint',
  'sumneko_lua',
})


-- TODO: TSserver dosent want to load so im using this keymaps
local bufopts = { noremap = true, silent = true }
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)

local luasnip = require("luasnip")
local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-Space>'] = cmp.mapping.complete(),
  ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
  ["<Tab>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    elseif luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
    elseif has_words_before() then
      cmp.complete()
    else
      fallback()
    end
  end, { "i", "s" }),
})


lsp.setup_nvim_cmp({
  mapping = cmp_mappings,
  sources = {
    { name = 'nvim_lsp', keyword_length = 1 },
    { name = 'luasnip',  keyword_length = 2 },
    { name = 'path' },
    { name = 'buffer',   keyword_length = 3 },
  },
})

-- local lsp_opts = {
--   single_file_support = false,
-- }

-- lsp.setup_servers({ 'html', 'cssls', opts = lsp_opts })



lsp.nvim_workspace()

lsp.set_preferences({
  suggest_lsp_servers = true
})

lsp.setup()

vim.diagnostic.config({ virtual_text = true })

-- yank highlight
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
