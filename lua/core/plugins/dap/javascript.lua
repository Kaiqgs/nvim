local utils_functions = require("utils.functions")

local M = {}

function M.bash_config()
  return {
    type = "pwa-node",
    request = "launch",
    name = "Launch Bash Run",
    cwd = vim.fn.getcwd(),
    runtimeExecutable = "bash",
    args = { "run.sh" },
    sourceMaps = true,
    protocol = "inspector",
    skipFiles = { "<node_internals>/**", "node_modules/**" },
    resolveSourceMapLocations = {
      "${workspaceFolder}/**",
      "!**/node_modules/**",
    },
  }
end
function M.setup()
  require("dap-vscode-js").setup({
    node_path = "node",
    debugger_path = utils_functions.get_vscode_js_debugger_path(),
  })
  local dap = require("dap")
  dap.configurations.javascript = { M.bash_config() }
end
return M
