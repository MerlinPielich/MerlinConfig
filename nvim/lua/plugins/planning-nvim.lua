-- Example Lazy.nvim config combining Kanban + Taskwarrior + Priority plugin
return {
  -- Main Kanban board
  {
    "arakkkkk/kanban.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
                opts = {		layout = {
			x_margin = 1,
			y_margin = 1,
			list_x_margin = 1,
			task_y_margin = 1,
			task_height = 3,
			uncomplete_border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
			complete_border = { "✔", "─", "╮", "│", "╯", "─", "╰", "│" },
		},},
    config = function()
      require("kanban").setup({
        markdown = {
          description_folder = "~/tasks/",  -- where task-note files go
          list_head = "## ",
        },
      })
      -- optional keymaps for quick access
      vim.keymap.set("n", "<leader>kb", ":KanbanOpen /home/merlin/Documents/Planning/weekPlanner.md<CR>")
require('blink.cmp').setup({
  sources = {
    default = { 'lsp', 'path', 'buffer', 'kanban' },
    providers = {
      kanban = {
        name = 'kanban',
        module = 'kanban.fn.cmp.blink.cmp',
        score_offset = 1, -- optional: bump priority
        opts = {},         -- reserved for future options
      },
    },
  },
})
    end,
  },

   -- Taskwarrior integration
  {
    "huantrinh1802/m_taskwarrior_d.nvim",
    config = function()
      require("m_taskwarrior_d").setup({
        -- any configs if needed
      })
      -- maybe map an overview: tasks due this week
      vim.keymap.set("n", "<leader>tw", ":Taskwarrior filter due.before:1w<CR>")
    end,
  },

  -- Priority / category manager
  {
    "hamidzr/task-manager.nvim",
    config = function()
      require("task-manager").setup({
        priority_format = "%s [p%d] %s",
        priority_pattern = "%[p(%d+)%]",
        keybindings = {
          prioritize_all = "tp",
          prioritize_new = "tn",
          sort_by_priority = "ts",
          toggle_checkbox = "tx",
        },
      })
    end,
  },

  -- Pomodoro plugin
  {
    "snehlsen/pomo.nvim",
    config = function()
      require("pomo").setup({
        -- your favorite pomodoro durations or config
      })
      vim.keymap.set("n", "<leader>pp", ":PomoStart<CR>")
      vim.keymap.set("n", "<leader>ps", ":PomoStop<CR>")
    end,
  },
}

