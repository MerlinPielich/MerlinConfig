return {
  -- Main SQL workflow
  {
    "tpope/vim-dadbod",
    ft = { "sql", "mysql", "plsql" },
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = { "tpope/vim-dadbod" },
    cmd = { "DBUI", "DBUIToggle", "DBUIFindBuffer", "DBUIRenameBuffer" },
    keys = {
      { "<leader>du", "<cmd>DBUIToggle<CR>", desc = "Toggle DBUI" },
    },
  },
  {
    "kristijanhusak/vim-dadbod-completion",
    dependencies = { "tpope/vim-dadbod", "hrsh7th/nvim-cmp" },
    ft = { "sql", "mysql", "plsql" },
  },

  -- Completion engine hook
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = opts.sources or {}
      table.insert(opts.sources, { name = "vim-dadbod-completion" })
    end,
  },

  -- Syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "sql" },
    },
  },

  -- Extra: Formatting & alignment
  {
    "godlygeek/tabular",
    ft = { "sql" },
    keys = {
      { "<leader>sa", ":%Tabularize /,/<CR>", desc = "Align SQL columns by comma" },
    },
  },
}




