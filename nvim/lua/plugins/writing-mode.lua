return {
  {
    "folke/zen-mode.nvim",
    dependencies = {
      "folke/twilight.nvim",
      "jubnzv/virtual-types.nvim", -- optional: inline type hints
      "folke/drop.nvim",           -- optional: chill visual vibe
    },
    config = function()
      local zen = require("zen-mode")
      local twilight = require("twilight")

      zen.setup({
        window = {
          backdrop = 0.99,   -- dim background slightly
          width = 80,        -- fixed text width for prose
          options = {
            number = true,
            relativenumber = true,
            signcolumn = "no",
          },
        },
        plugins = {
          options = {
            enabled = true,
            ruler = true,
            showcmd = false,
          },
        },
      })

      twilight.setup({
        dimming = {
          alpha = 0.85,
        },
        context = 15, -- keep a few surrounding lines lit
      })

      -- Toggle Writing Mode
      vim.api.nvim_create_user_command("WritingMode", function()
        vim.cmd("Twilight")
        zen.toggle()
        vim.cmd("TWToggle")
      end, { desc = "Toggle Writing Mode" })

      -- Keymap
      vim.keymap.set("n", "<leader>ww", "<cmd>WritingMode<CR>", { desc = "Toggle Writing Mode" })
    end,
  },
}

