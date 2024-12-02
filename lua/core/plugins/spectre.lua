return {
	"nvim-pack/nvim-spectre",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("spectre").setup({
			find_engine = {
				["rg"] = {
					cmd = "rg",
					-- default args
					args = {
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
					},
					options = {
						["ignore-case"] = {
							value = "--ignore-case",
							icon = "[I]",
							desc = "ignore case",
						},
						["hidden"] = {
							value = "--hidden",
							desc = "hidden file",
							icon = "[H]",
						},
						["pcre"] = {
							value = "--pcre2",
							icon = "[P]",
							desc = "look-around",
						},
						-- you can put any rg search option you want here it can toggle with
						-- show_option function
					},
				},
			},
		})
	end,
	enabled = vim.g.config.plugins.spectre.enable,
	keys = {
		{ "<leader>R", "", desc = "Replace" },
		{
			"<leader>Rr",
			function()
				require("spectre").toggle()
			end,
			desc = "Toggle search and replace",
		},
		{
			"<leader>Rw",
			function()
				require("spectre").open_visual({ select_word = true })
			end,
			desc = "Search current word",
		},
		{
			"<leader>Rw",
			mode = "v",
			function()
				require("spectre").open_visual({ select_word = true })
			end,
			desc = "Search current word",
		},
		{
			"<leader>Rf",
			function()
				require("spectre").open_file_search({ select_word = true })
			end,
			desc = "Search in current file",
		},
		{
			"<leader>Rc",
			function()
				require("spectre.actions").run_current_replace()
			end,
			desc = "Replace current",
		},
		{
			"<leader>RR",
			function()
				require("spectre.actions").run_replace()
			end,
			desc = "Replace all",
		},
	},
}
