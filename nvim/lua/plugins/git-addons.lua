return {
  -- Inline git signs in the gutter
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add          = { text = "│" },
        change       = { text = "│" },
        delete       = { text = "_" },
        topdelete    = { text = "‾" },
        changedelete = { text = "~" },
      },
      current_line_blame = true,
    },
  },

  -- VS Code–style conflict resolution
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = function()
      require("git-conflict").setup()

    end,
  },

  -- Full diff/merge/review UI
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    config = function()
      require("diffview").setup({
        enhanced_diff_hl = true,
      })

      -- Keymaps for diffview
      vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<CR>",       { desc = "Open Diffview" })
      vim.keymap.set("n", "<leader>gD", "<cmd>DiffviewClose<CR>",      { desc = "Close Diffview" })
      vim.keymap.set("n", "<leader>gh", "<cmd>DiffviewFileHistory<CR>",{ desc = "File history" })
    end,
  },

  -- Telescope with Git pickers
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          layout_strategy = "vertical",
          layout_config = { preview_height = 0.5 },
        },
      })
      -- 🔭 Telescope Git keymaps
      local builtin = require("telescope.builtin")
      local gc = require("git-conflict")
  
    local wk = require("which-key")
    -- All your git-related maps under <leader>g
        local gmaps = {
          g = {
            name = "+git", -- This gives you the group name in which-key
            s = { ":Git status<CR>", "Status" },
            c = { ":Git commit<CR>", "Commit" },
            P = { ":Git push<CR>", "Push" },
            l = { ":Git log<CR>", "Log" },
            o = { ":Git Choose ours <CR>", "Ours"},
            x = { ":Git Choose none<CR>", "None"},
            t = { ":Git Choose theirs<CR>", "theirs" },
            b = { ":Git Choose both<CR>", "both" },
            n = { ":Git Go to next conflict", "next"},
            p = { ":Git Go to previous conflict","prev"}
          },
        }
    -- Set which key so that they will be unbound in the menu
    -- Set the Git keymaps
    local function set_git_keymaps()
      vim.keymap.set("n", "<leader>gc", builtin.git_commits,   { desc = "Search commits" })
      vim.keymap.set("n", "<leader>gB", builtin.git_branches,  { desc = "Search branches" })
      vim.keymap.set("n", "<leader>gs", builtin.git_status,    { desc = "Search git status" })
      vim.keymap.set("n", "<leader>gS", builtin.git_stash,     { desc = "Search stash" })
      -- Keymaps for resolving conflicts
      vim.keymap.set("n", "<leader>go",gc.GitConflictChooseOurs ,{ desc = "Choose ours" })
      vim.keymap.set("n", "<leader>gt", gc.GitConflictChooseTheirs, { desc = "Choose theirs" })
      vim.keymap.set("n", "<leader>gb", gc.GitConflictChooseBoth,   { desc = "Choose both" })
      vim.keymap.set("n", "<leader>gx", gc.GitConflictChooseNone,   { desc = "Choose none" })
      vim.keymap.set("n", "<leader>gn", gc.GitConflictNextConflict,  { desc = "Next conflict" })
      vim.keymap.set("n", "<leader>gp",gc.GitConflictPrevConflict,  { desc = "Prev conflict" })
        wk.register(gmaps)
    end

    local git_keymaps_active = false

    -- unset the git keymaps
    local function unset_git_keymaps()
        vim.keymap.del("n", "<leader>gc")
        vim.keymap.del("n", "<leader>gB")
        vim.keymap.del("n", "<leader>gs")
        vim.keymap.del("n", "<leader>gS")
        vim.keymap.del("n", "<leader>go")
        vim.keymap.del("n", "<leader>gt")
        vim.keymap.del("n", "<leader>gb")
        vim.keymap.del("n", "<leader>gx")
        vim.keymap.del("n", "<leader>gn")
        vim.keymap.del("n", "<leader>gp")
        wk.unregister("<leader>g",{mode = "n"})
    end

    -- Toggle git keymaps
            --
        local ToggleGitKeymaps = function()
            if git_keymaps_active then
                unset_git_keymaps()
                git_keymaps_active = false
                vim.notify("Git keymaps enabled")
            else
                set_git_keymaps()
                git_keymaps_active = true
                vim.notify("Git keymaps disabled")
            end
        end

    vim.api.nvim_create_user_command("ToggleGitKeymaps",ToggleGitKeymaps,{nargs = 0, desc = "Toggle git commands",bang=true})
    vim.keymap.set("n", "<leader>tk",vim.cmd.ToggleGitKeymaps(), {desc = "Toggle git keymaps"})

    end,
    }


}

