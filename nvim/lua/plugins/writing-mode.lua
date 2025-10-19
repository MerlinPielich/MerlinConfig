return {
	{
		"folke/zen-mode.nvim",
		dependencies = {
			"joshuadanpeterson/typewriter.nvim",
			"jubnzv/virtual-types.nvim", -- optional: inline type hints
			"folke/drop.nvim", -- optional: chill visual vibe
		},
		config = function()
			local zen = require("zen-mode")
			zen.setup({
				window = {
					backdrop = 1, -- dim background slightly
					width = 0.70, -- fixed text width for prose
					height = 1.00,
					options = {
						number = true,
						relativenumber = true,
						signcolumn = "no",
						cursorline = true,
						list = true,
					},
				},
				plugins = {
					options = {
						enabled = true,
						ruler = true,
						showcmd = false,
						laststatus = 0,
					},
					twilight = { enabled = false },
				},
			})

			-- Toggle Writing Mode
			vim.api.nvim_create_user_command("WritingMode", function()
				zen.toggle()
				vim.cmd("TWToggle")
			end, { desc = "Toggle Writing Mode" })

			-- Keymap
			vim.keymap.set("n", "<leader>ww", "<cmd>WritingMode<CR>", { desc = "Toggle Writing Mode" })
		end,
	},
}
