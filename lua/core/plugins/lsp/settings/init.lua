local M = {}

M.lua = require("core.plugins.lsp.settings.lua_ls")
M.json = require("core.plugins.lsp.settings.jsonls")
M.yaml = require("core.plugins.lsp.settings.yaml")
M.glsl = require("core.plugins.lsp.settings.glsl")
M.clangd = require("core.plugins.lsp.settings.clangd")

return M
