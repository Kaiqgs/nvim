local javascript = require("core.plugins.dap.javascript")
local utils_functions = require("utils.functions")
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
        },
      },
      javascript.bash_config(),
    }
  end,
}
return M
