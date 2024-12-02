local javascript = require("core.plugins.dap.javascript")
local utils_functions = require("utils.functions")
local function colyseus_froom_root()
	return {
		type = "pwa-node",
		request = "launch",
		name = "Launch Colyseus Server: from root",
		cwd = vim.fn.getcwd(),
		runtimeExecutable = "bash",
		args = { "ci/server.sh" },
		"${workspaceFolder}/**",
		"!**/node_modules/**",
	}
end

function M.ng_test_config()
	return {
		name = "Launch Bash Test",
		type = "pwa-node",
		request = "launch",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		runtimeExecutable = "bash",
		args = { "test.sh" },
		sourceMaps = true,
		skipFiles = { "<node_internals>/**", "node_modules/**" },
		resolveSourceMapLocations = {
			"${workspaceFolder}/**",
			"!**/node_modules/**",
			-- "${workspaceFolder}/server/src/**",
			-- "${workspaceFolder}/shared/src/**",
		},
	}
end

local M = {
	setup = function()
		local osname = vim.loop.os_uname().sysname
		local is_windows = osname:find("Windows")
		local debugger_path = "C:/Users/Kaique/Documents/Scripts/vscode-js-debug" and is_windows
			-- or "/home/kags/vscode-js-debug"
			or "~/3rdParty/vscode-js-debug"
		require("dap-vscode-js").setup({
			node_path = "node",
			debugger_path = utils_functions.get_vscode_js_debugger_path(),
		})
		local dap = require("dap")
		dap.configurations.typescript = {
			colyseus_froom_root(),
			{
				type = "pwa-node",
				request = "launch",
				name = "Launch Colyseus Server",
				cwd = vim.fn.getcwd(),
				runtimeExecutable = "npm",
				args = { "start" },
				sourceMaps = true,
				protocol = "inspector",
				skipFiles = { "<node_internals>/**", "node_modules/**" },
				resolveSourceMapLocations = {
					"${workspaceFolder}/**",
					"!**/node_modules/**",
					"${workspaceFolder}/../shared/src/**",
				},
			},
			javascript.bash_config(),
			M.ng_test_config(),
		}
		--         dap.listeners.after["event_terminate"]["ts-plug"] = function(session, body)
		--             local op = io.popen("lsof -i :2567")
		--             op:read()
		--             local data = op:read()
		--             op:close()
		--             local pid = data:gmatch("%d+")()
		--             if pid then
		--                 local killop = io.popen(("kill -9 %s"):format(pid))
		--                 print("killing op")
		--                 print(killop:read("*a"))
		--                 killop:close()
		--             end
		--         end
	end,
}
return M
