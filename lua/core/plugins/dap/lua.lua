local utils_functions = require("utils.functions")
local M = {}

local function get_other_defold_config()
    return {
        name = "attach to defold",
        type = "local-lua",
        request = "attach",
        pid = require('dap.utils').pick_process,
        args={}

    }
    
end
local function get_defold_config()
    return {
        name = "Debug Defold",
        type = "local-lua",
        request = "launch",
        cwd = vim.fn.getcwd(),
        program = {
            command = "./dmengine",
        },
        args = {"./build/default/game.projectc"},
        script_roots = {"."},
        scriptRoots = {"."}
            
    }

    --    {
    --   "version": "0.2.0",
    --   "configurations": [
    --     {
    --       "name": "Debug",
    --       "type": "lua-local",
    --       "request": "launch",
    --       "program": {
    --         "command": "dmengine"
    --       },
    --       "args": ["./build/default/game.projectc"],
    --       "scriptRoots": ["."] // Required for debugger to find scripts
    --     }
    --   ]
    -- }
end

function M.setup()
    local dap = require("dap")
    dap.adapters["local-lua"] = {
        type = "executable",
        command = "node",
        args = {
            utils_functions.get_local_lua_debugger_path()
        },
        enrich_config = function(config, on_config)
            if not config["extensionPath"] then
                local c = vim.deepcopy(config)
                -- 💀 If this is missing or wrong you'll see
                -- "module 'lldebugger' not found" errors in the dap-repl when trying to launch a debug session
                -- c.extensionPath = "/absolute/path/to/local-lua-debugger-vscode/"
                -- print("set this you filthy animal", c.extensionPath)
                c.extensionPath = utils_functions.get_local_lua_extension_path()
                on_config(c)
            else
                on_config(config)
            end
        end,
    }
    dap.configurations.lua = {
        get_defold_config(),
        get_other_defold_config()
    }
end

return M
