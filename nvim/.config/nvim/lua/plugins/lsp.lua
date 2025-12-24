return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("LspKeymaps", { clear = true }),
        callback = function(ev)
          local map = function(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, {
              buffer = ev.buf,
              desc = "LSP: " .. desc,
            })
          end

          map("gd", function()
            MiniExtra.pickers.lsp({ scope = "definition" })
          end, "Goto definition")

          map("gr", function()
            MiniExtra.pickers.lsp({ scope = "references" })
          end, "Goto references")

          map("gi", function()
            MiniExtra.pickers.lsp({ scope = "implementation" })
          end, "Goto implementation")

          map("<leader>D", function()
            MiniExtra.pickers.lsp({ scope = "type_definition" })
          end, "Type definition")

          map("<leader>ds", function()
            MiniExtra.pickers.lsp({ scope = "document_symbol" })
          end, "Document symbols")

          map("K", vim.lsp.buf.hover, "Hover")
          map("<leader>lr", vim.lsp.buf.rename, "Rename")
          map("<leader>la", vim.lsp.buf.code_action, "Code action")
        end,
      })
    end,
  },
  {
    "mason-org/mason.nvim",
    opts = {}
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    opts = {
      ensure_installed = { 'bash', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
  }
}
