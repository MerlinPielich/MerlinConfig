local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
require("vimOptions")
require("config.keymaps")
require("config.diagnostics")
require("config.autocmds")
require("lazy").setup("plugins")
vim.wo.relativenumber = true
vim.wo.number = true
vim.keymap.set("n", "<leader>tw", function()
	vim.cmd("edit /home/merlin/Documents/Planning/queries.md") -- adjust path
	vim.cmd("TWBufQueryTasks")
end, { noremap = true, silent = true, desc = "Open weekly overview" })

-- Set local indentation rules for assembly
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "asm" },
	callback = function()
		vim.opt_local.expandtab = true
		vim.opt_local.tabstop = 8
		vim.opt_local.softtabstop = 8
		vim.opt_local.shiftwidth = 8
		vim.opt_local.autoindent = true
		vim.opt_local.smartindent =true
	end,
})

-- Configure Conform to use asmfmt + expand
require("conform").setup({
	formatters = {
		asmfmt_spaces = {
			command = "zsh",
			args = {
				"-c",
				"asmfmt | expand -t 8",
			},
			stdin = true,
		},
	},
	formatters_by_ft = {
		asm = { "asmfmt_spaces" },
	},
})
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.s", "*.asm", "*.S" },
	callback = function()
		require("conform").format()
	end,
})
