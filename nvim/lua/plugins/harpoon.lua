return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")

      harpoon:setup({
        settings = {
          save_on_toggle = true,
          sync_on_ui_close = true,
        },
      })

      -- KEYBINDINGS
      local wk = require("which-key")

      wk.add({
        { "<leader>h", group = "Harpoon" },
        { "<leader>ha", function() harpoon:list():add() end, desc = "Add file" },
        { "<leader>hl", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "List files" },
        { "<leader>h1", function() harpoon:list():select(1) end, desc = "Go to file 1" },
        { "<leader>h2", function() harpoon:list():select(2) end, desc = "Go to file 2" },
        { "<leader>h3", function() harpoon:list():select(3) end, desc = "Go to file 3" },
        { "<leader>h4", function() harpoon:list():select(4) end, desc = "Go to file 4" },
        { "<leader>hn", function() harpoon:list():next() end, desc = "Next mark" },
        { "<leader>hp", function() harpoon:list():prev() end, desc = "Prev mark" },
      })
    end,
  },
}
