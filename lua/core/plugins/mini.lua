local plugins = vim.g.config.plugins

return {

	{
		"echasnovski/mini.comment",
		event = { "BufReadPre", "BufNewFile" },
		-- is not loaded without explicitly saying it
		config = true,
	},

	{
		"echasnovski/mini.align",
		event = { "BufReadPre", "BufNewFile" },
		-- is not loaded without explicitly saying it
		config = true,
	},

	{
		"echasnovski/mini.test",
		event = { "BufReadPre", "BufNewFile" },
	},

	{
		"echasnovski/mini.hipatterns",
		event = { "BufReadPre", "BufNewFile" },
		opts = function()
			local hi = require("mini.hipatterns")
			return {
				highlighters = {
					-- Highlight 'FIXME', 'HACK', 'TODO', 'NOTE'
					fixme = {
						pattern = "%f[%w]()FIXME()%f[%W]",
						group = "MiniHipatternsFixme",
					},
					hack = {
						pattern = "%f[%w]()HACK()%f[%W]",
						group = "MiniHipatternsHack",
					},
					todo = {
						pattern = "%f[%w]()TODO()%f[%W]",
						group = "MiniHipatternsTodo",
					},
					note = {
						pattern = "%f[%w]()NOTE()%f[%W]",
						group = "MiniHipatternsNote",
					},
					hex_color = hi.gen_highlighter.hex_color(),
					-- TODO: tailwind integration?
				},
			}
		end,
	},

	{
		"echasnovski/mini.pick",
		event = { "VimEnter" },
		opts = {
			mappings = plugins.mini_pick.mappings,
		},
		config = function(_, opts)
			require("mini.pick").setup(opts)
		end,
	},
}
