return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        -- initial state; autocmds.lua dynamically toggles between virtual_text and virtual_lines
        virtual_text = true,
        virtual_lines = false,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
          },
          linehl = {},
          numhl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
            [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
            [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
            [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
          },
        },
      },
      inlay_hints = { enabled = true },
      document_highlight = { enabled = false },
    },
  },
}
