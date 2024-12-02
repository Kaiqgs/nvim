return {
	"kylechui/nvim-surround",
	version = "*", -- Use for stability; omit to use `main` branch for the latest features
	event = "VeryLazy",
	config = function()
		require("nvim-surround").setup({
			keymaps = {
				normal = "ms",
				normal_cur = "mss",
				normal_line = "mS",
				normal_cur_line = "mSS",
				visual = "S",
				visual_line = "gS",
				insert = "<C-g>s",
				insert_line = "<C-g>S",
				delete = "ds",
				change = "cs",
				change_line = "cS",
			},
			-- Configuration here, or leave empty to use defaults
		})
	end,
}
