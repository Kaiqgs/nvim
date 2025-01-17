local defold = require("utils.defold")
local api = vim.api

--- Remove all trailing whitespace on save
local TrimWhiteSpaceGrp = api.nvim_create_augroup("TrimWhiteSpaceGrp", { clear = true })
api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		if STRIP_WHITESPACE then
			local command = [[:%s/\s\+$//e]]
			vim.cmd(command)
		end
	end,
	group = TrimWhiteSpaceGrp,
})

vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
	end,
	desc = "Disable New Line Comment",
})

-- wrap words "softly" (no carriage return) in mail buffer
api.nvim_create_autocmd("Filetype", {
	pattern = "mail",
	callback = function()
		vim.opt.textwidth = 0
		vim.opt.wrapmargin = 0
		vim.opt.wrap = true
		vim.opt.linebreak = true
		vim.opt.columns = 80
		vim.opt.colorcolumn = "80"
	end,
})

-- Highlight on yank
api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- go to last loc when opening a buffer
api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- windows to close with "q"
api.nvim_create_autocmd("FileType", {
	pattern = {
		"dap-float",
		"fugitive",
		"help",
		"man",
		"notify",
		"null-ls-info",
		"qf",
		"PlenaryTestPopup",
		"startuptime",
		"tsplayground",
		"spectre_panel",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})
api.nvim_create_autocmd("FileType", { pattern = "man", command = [[nnoremap <buffer><silent> q :quit<CR>]] })

-- disable list option in certain filetypes
api.nvim_create_autocmd("FileType", { pattern = { "NeoGitStatus" }, command = [[setlocal list!]] })

-- show cursor line only in active window
local cursorGrp = api.nvim_create_augroup("CursorLine", { clear = true })
api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
	pattern = "*",
	command = "set cursorline",
	group = cursorGrp,
})
api.nvim_create_autocmd(
	{ "InsertEnter", "WinLeave" },
	{ pattern = "*", command = "set nocursorline", group = cursorGrp }
)

-- when there is no buffer left show Alpha dashboard
-- requires "famiu/bufdelete.nvim" and "goolord/alpha-nvim"
local alpha_on_empty = api.nvim_create_augroup("alpha_on_empty", { clear = true })
api.nvim_create_autocmd("User", {
	pattern = "BDeletePost*",
	group = alpha_on_empty,
	callback = function(event)
		local fallback_name = vim.api.nvim_buf_get_name(event.buf)
		local fallback_ft = vim.api.nvim_buf_get_option(event.buf, "filetype")
		local fallback_on_empty = fallback_name == "" and fallback_ft == ""

		if fallback_on_empty then
			-- require("neo-tree").close_all()
			vim.api.nvim_command("Alpha")
			vim.api.nvim_command(event.buf .. "bwipeout")
		end
	end,
})

-- Enable spell checking for certain file types
api.nvim_create_autocmd(
	{ "BufRead", "BufNewFile" },
	-- { pattern = { "*.txt", "*.md", "*.tex" }, command = [[setlocal spell<cr> setlocal spelllang=en,de<cr>]] }
	{
		pattern = { "*.txt", "*.md", "*.tex", "*.typ" },
		callback = function()
			vim.opt.spell = true
			vim.opt.spelllang = "en"
		end,
	}
)
-- vim.api.nvim_create_augroup("LuaCustomFiletype")
-- vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
--     command = [[
--
--     auto FileType defold_lua setlocal syntax=lua
--     autocmd FileType defold_lua setlocal filetype=lua
--         ]],
--     group = "LuaCustomFiletype",
-- })

-- detect defold file extensions
local defold_file_maps = {
	glsl = { "vp", "fp" },
	lua = {
		"script",
		"gui_script",
		"render_script",
		"editor_script",
		"lua",
	},
	-- TODO: match this with a proper root `game.project` file to avoid golang conflicts (use callback below)
	defold_go = {  }, -- "go"
}
for lang, defold_correspondents in pairs(defold_file_maps) do
	for _, file_ext in ipairs(defold_correspondents) do
		vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
			-- command = ("set filetype=%s"):format(lang),
			callback = function(args)
				vim.bo.filetype = lang
				-- vim.b.is_defold = defold.is_defold_project(args.file)
			end,
			pattern = { ("*.%s"):format(file_ext) },
		})
	end
end
