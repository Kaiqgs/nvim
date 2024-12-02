local conf = vim.g.config
local inspect = require("utils.inspect")
local lspconfig = require("lspconfig")
local utils = require("core.plugins.lsp.utils")
local lsp_settings = require("core.plugins.lsp.settings")

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- enable autocompletion via nvim-cmp
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

require("utils.functions").on_attach(function(client, buffer)
	require("core.plugins.lsp.keys_alt").on_attach(client, buffer)
end)

-- for _

for setting_ls, settings in pairs(lsp_settings) do
	local found = false
	for _, lsp in ipairs(conf.lsp_servers) do
		if lsp == setting_ls then
			found = true
			break
		end
	end
	assert(found, "No settings found for " .. setting_ls)
end

for _, lsp in ipairs(conf.lsp_servers) do
	local settings_or = lsp_settings[lsp] or {}
	-- assert(lsp_settings[lsp], "No settings found for " .. lsp)
	print(settings_or.filetypes, lsp)
	-- print(inspect(lsp_settings))
	lspconfig[lsp].setup({
		before_init = function(_, config)
			if lsp == "pyright" then
				config.settings.python.pythonPath = utils.get_python_path(config.root_dir)
			end
		end,
		capabilities = capabilities,
		flags = { debounce_text_changes = 150 },
		single_file_support = settings_or.single_file_support,
		settings = settings_or,
		on_attach = settings_or.on_attach,
		root_dir = settings_or.root_dir,
		filetypes = settings_or.filetypes,
	})
end
