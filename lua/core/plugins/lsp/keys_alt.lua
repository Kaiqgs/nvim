local M = {}

M._keys = {
	{ "<leader>gD", vim.lsp.buf.declaration, desc = "[G]oto [D]eclaration" },
	{ "<leader>ld", vim.diagnostic.open_float, desc = "[L]ine [D]iagnostics" },
	-- { "<leader>lR", vim.lsp.buf.rename, desc = "Rename", has = "rename" },
	{
		"<leader>rn",
		function()
			require("inc_rename")
			return ":IncRename " .. vim.fn.expand("<cword>")
		end,
		expr = true,
		desc = "[R]e[n]ame",
		has = "rename",
	},
	{ "<leader>li", "<cmd>LspInfo<cr>", desc = "[L]sp [I]nfo" },
	{
		"<leader>gd",
		function()
			require("telescope.builtin").lsp_definitions({ reuse_win = true })
		end,
		desc = "[G]oto [D]efinition",
		has = "definition",
	},
	{ "<leader>gr", "<cmd>Telescope lsp_references<cr>", desc = "[G]oto [R]eferences" },
	{
		"<leader>gI",
		function()
			require("telescope.builtin").lsp_implementations({ reuse_win = true })
		end,
		desc = "[G]oto [I]mplementation",
	},
	{
		"<leader>gT",
		function()
			require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
		end,
		desc = "[G]oto [T]ype Definition",
	},
	{ "<leader>K", vim.lsp.buf.hover, desc = "Hover" },
	{ "<leader>ls", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
	{ "<leader>ca", vim.lsp.buf.code_action, desc = "[C]ode [A]ction", mode = { "n", "v" }, has = "codeAction" },
	-- { "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" },
	{ "<leader>dn", vim.diagnostic.goto_next, desc = "[D]iagnostic [N]ext" },
	{ "<leader>dp", vim.diagnostic.goto_prev, desc = "[D]iagnostic [P]rev" },
	{ "<leader>ds", "<cmd>Telescope lsp_document_symbols<cr>", desc = "[D]ocument [S]ymbols" },
	{ "<leader>dd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "[D]ocument [D]iagnostics" },
	{ "<leader>dq", vim.diagnostic.setloclist, desc = "[D]iagnostics in [q]flist" },
	{ "<leader>qws", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols" },
	{ "<leader>lwd", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Symbols" },
	{ "<leader>lwa", vim.lsp.buf.add_workspace_folder, desc = "Add Folder" },
	{ "<leader>lwl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>", desc = "List Folders" },
	{ "<leader>lwr", vim.lsp.buf.remove_workspace_folder, desc = "Remove Folder" },
}

function M.on_attach(client, buffer)
	local Keys = require("lazy.core.handler.keys")
	local keymaps = {}
	-- local wk = require("which-key")

	-- wk.register({
	--   l = {
	--     w = { "Workspaces" },
	--   },
	-- }, { prefix = "<leader>", mode = "n" })

	for _, value in ipairs(M._keys) do
		local keys = Keys.parse(value)
		if keys.rhs == vim.NIL or keys.rhs == false then
			keymaps[keys.id] = nil
		else
			keymaps[keys.id] = keys
		end
	end

	for _, keys in pairs(keymaps) do
		if not keys.has or client.server_capabilities[keys.has .. "Provider"] then
			local opts = Keys.opts(keys)
			opts.has = nil
			opts.silent = opts.silent ~= false
			opts.buffer = buffer
			vim.keymap.set(keys.mode or "n", keys.lhs, keys.rhs, opts)
		end
	end
end

return M
