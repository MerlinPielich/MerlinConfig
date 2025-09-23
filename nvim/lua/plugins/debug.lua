return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio"
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- UI setup
      dapui.setup()
      require("nvim-dap-virtual-text").setup()

      -- Keymaps (Corne-friendly, no F-keys)
      -- vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
      -- vim.keymap.set("n", "<leader>dn", dap.step_over, { desc = "Step Over" })
      -- vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
      -- vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Step Out" })
      -- vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
      -- vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })

      -- Adapter: cpptools (works for C, C++, and assembly)
      dap.adapters.cppdbg = {
        id = "cppdbg",
        type = "executable",
        command = "//usr/share/cpptools-debug/bin/OpenDebugAD7",

      }

      -- Configurations
      dap.configurations.cpp = {
        {
          name = "Launch assembly program",
          type = "cppdbg",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopAtEntry = true,
          setupCommands = {
            {
              text = "-enable-pretty-printing",
              description = "enable pretty printing",
              ignoreFailures = false,
            },
          },
        },
      }

      -- Reuse the same config for .s and .asm files
      dap.configurations.asm = dap.configurations.cpp
      dap.configurations.s = dap.configurations.cpp
    end,
  },
}

