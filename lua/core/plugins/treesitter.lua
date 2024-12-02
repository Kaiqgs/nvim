local defold = require("utils.defold")
local M = {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"RRethy/nvim-treesitter-endwise",
		"mfussenegger/nvim-ts-hint-textobject",
		"windwp/nvim-ts-autotag",
		"nvim-treesitter/playground",
	},
	config = function()
		local conf = vim.g.config
		require("nvim-treesitter.configs").setup({
			ensure_installed = conf.treesitter_ensure_installed,
			ignore_install = {}, -- List of parsers to ignore installing
			highlight = {
				enable = true, -- false will disable the whole extension
				disable = {}, -- list of language that will be disabled
				additional_vim_regex_highlighting = false,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<CR>",
					scope_incremental = "<CR>",
					node_incremental = "<TAB>",
					node_decremental = "<S-TAB>",
				},
			},
			endwise = {
				enable = true,
			},
			indent = { enable = true },
			autopairs = { enable = true },
			textobjects = {
				select = {
					enable = true,
					-- Automatically jump forward to textobj, similar to targets.vim
					lookahead = true,
					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
						["al"] = "@loop.outer",
						["il"] = "@loop.inner",
						["ib"] = "@block.inner",
						["ab"] = "@block.outer",
						["ir"] = "@parameter.inner",
						["ar"] = "@parameter.outer",
					},
				},
			},
		})

		local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
		parser_config[defold.defold_lua] = {
			install_info = {
				url = "", -- Not needed as we're using the Lua parser
			},
			filetype = defold.defold_lua,
			used_by = { defold.defold_lua },
		}

		require("nvim-ts-autotag").setup()
	end,
}

return M
