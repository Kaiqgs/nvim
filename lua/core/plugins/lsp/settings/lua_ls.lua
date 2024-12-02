local defold = require("utils.defold")
-- https://github.com/sumneko/lua-language-server/blob/master/locale/en-us/setting.lua
local opts = {
	filetypes = {
		"lua",
		defold.defold_lua,
	},
	format = {
		enable = true, -- let null-ls handle the formatting
		defaultConfig = {
			column_width = 80,
		},
	},
	diagnostics = { globals = { "vim" } },
	telemetry = { enable = false },
}

return opts
