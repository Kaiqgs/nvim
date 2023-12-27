local M = {
  setup = function()
    require("dap-vscode-js").setup({
      node_path = "node",
      --TODO: remove hardcoded windows path
      debugger_path = "C:/Users/Kaique/Documents/Scripts/vscode-js-debug",
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
    }
  end,
}
return M
