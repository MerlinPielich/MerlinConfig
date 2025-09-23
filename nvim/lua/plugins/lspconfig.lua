return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Lua LS
      vim.lsp.config("lua_ls", {})
      vim.lsp.enable("lua_ls")

      -- Python
      vim.lsp.config("pyright", {})
      vim.lsp.enable("pyright")

      -- TypeScript / JavaScript
      vim.lsp.config("tsserver", {})
      vim.lsp.enable("tsserver")

      -- Rust
      vim.lsp.config("rust_analyzer", {})
      vim.lsp.enable("rust_analyzer")

      -- C / C++
      vim.lsp.config("clangd", {})
      vim.lsp.enable("clangd")

    end,
  },
}

