local M = {
	defold_lua = "defold_lua",
}

function M.is_defold_project(filepath)
	local dir = vim.fn.fnamemodify(filepath, ":p:h")
	while dir and dir ~= "/" do
		if vim.fn.globpath(dir, "game.project") ~= "" then
			return true
		end
		local parent_dir = vim.fn.fnamemodify(dir, ":h")
		if parent_dir == dir then
			break
		end
		dir = parent_dir
	end
	return false
end

return M
