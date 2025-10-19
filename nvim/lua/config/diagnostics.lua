-- pull in your icons
local icons = require("config.icons").diagnostics

-- configure diagnostics in one place
vim.diagnostic.config({
	underline = true,
	update_in_insert = false,
	virtual_text = { spacing = 4, prefix = "●" },
	severity_sort = true,
	signs = {
		text = {
			Error = icons.Error,
			Warn = icons.Warn,
			Hint = icons.Hint,
			Info = icons.Info,
		},
	},
})
