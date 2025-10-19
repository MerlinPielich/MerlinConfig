return {
	"akinsho/toggleterm.nvim",
	version = "*",
	opts = {
		open_mapping = [[<c-\>]],
		direction = "float",
		float_opts = {
			-- The border key is *almost* the same as 'nvim_open_win'
			-- see :h nvim_open_win for details on borders however
			-- the 'curved' border is a custom border type
			-- not natively supported but implemented in this plugin.
			border = "curved",
			-- like `size`, width, height, row, and col can be a number or function which is passed the current terminal
			width = 90,
			height = 15,
			-- zindex = <value>,
			title_pos = "center",
		},
	},
}
