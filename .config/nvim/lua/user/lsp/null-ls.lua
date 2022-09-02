require("null-ls").setup({
    sources = {
      require("null-ls").builtins.formatting.stylua,
      require("null-ls").builtins.diagnostics.eslint,
      require('null-ls').builtins.formatting.prettier.with({extra_args = { "--no-semi", "--single-quote", "--jsx-single-qoute"}}), 
    },
})
