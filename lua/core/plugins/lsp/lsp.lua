local conf = vim.g.config
local nvim_lsp = require("lspconfig")
local utils = require("core.plugins.lsp.utils")
local lsp_settings = require("core.plugins.lsp.settings")

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- enable autocompletion via nvim-cmp
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

require("utils.functions").on_attach(function(client, buffer)
  require("core.plugins.lsp.keys_alt").on_attach(client, buffer)
end)

for _, lsp in ipairs(conf.lsp_servers) do
  nvim_lsp[lsp].setup({
    before_init = function(_, config)
      if lsp == "pyright" then
        config.settings.python.pythonPath = utils.get_python_path(config.root_dir)
      end
    end,
    capabilities = capabilities,
    flags = { debounce_text_changes = 150 },
    settings = {
      json = lsp_settings.json,
      Lua = lsp_settings.lua,
      ltex = lsp_settings.ltex,
      redhat = { telemetry = { enabled = false } },
      texlab = lsp_settings.tex,
      yaml = lsp_settings.yaml,
      glslls = lsp_settings.glsl,
      clangd = lsp_settings.clangd,
      -- arduino_language_server = lsp_settings.arduino_language_server,
    },
  })
end
