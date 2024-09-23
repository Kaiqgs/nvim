local M = {}
function M.setup(_)

    -- table.insert(require("dap").configurations.python, {
        -- type = "python",
        -- request = "launch",
        -- name = "Custom",
        -- program = "${file}",
    -- })
    
    require("dap-python").setup(
        "python3",
        { include_configs = true, pythonPath = "/home/kags/Desktop/purespectrum/device-intelligence/dvi/bin/python3" }
    )
end

return M
