-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }

-- highlight on hover 
-- if client.server_capabilities.documentHighlightProvider then
--     vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
--     vim.api.nvim_clear_autocmds { buffer = bufnr, group = "lsp_document_highlight" }
--     vim.api.nvim_create_autocmd("CursorHold", {
--         callback = vim.lsp.buf.document_highlight,
--         buffer = bufnr,
--         group = "lsp_document_highlight",
--         desc = "Document Highlight",
--     })
--     vim.api.nvim_create_autocmd("CursorMoved", {
--         callback = vim.lsp.buf.clear_references,
--         buffer = bufnr,
--         group = "lsp_document_highlight",
--         desc = "Clear All the References",
--     })
-- end

-- format on save
-- if client.server_capabilities.documentFormattingProvider then
--   vim.api.nvim_create_autocmd("BufWritePre", {
--     group = vim.api.nvim_create_augroup("Format", { clear = true }),
--     buffer = bufnr,
--     callback = function() vim.lsp.buf.formatting_seq_sync() end
--   })
-- end

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

local on_attach = function(client, bufnr)
  local bufopts = { noremap=true, silent=true, buffer=bufnr }

  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
   
end

local lsp_flags = {
}

local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.diagnostic.config({virtual_text = false})

require('lspconfig')['tsserver'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities
}

-- require('lspconfig')['prisma-language-server'].setup{
--     on_attach = on_attach,
--     flags = lsp_flags,
--     capabilities = capabilities
-- }

-- require('lspconfig')['sumeko_lua'].setup{
--     on_attach = on_attach,
--     flags = lsp_flags,
--     capabilities = capabilities,
-- }
