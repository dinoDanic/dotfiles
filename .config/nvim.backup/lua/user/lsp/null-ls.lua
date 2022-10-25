require("null-ls").setup({
    sources = {
      require("null-ls").builtins.diagnostics.eslint,
      require('null-ls').builtins.formatting.prettier, 
    },
})


-- local extra_args = { "--no-semi", "--single-quote", "--jsx-single-qoute"}
-- require('null-ls').builtins.formatting.prettier.with({extra_args}), 
