local M = {}

M.lua_ls = require("core.plugins.lsp.settings.lua_ls")
M.jsonls = require("core.plugins.lsp.settings.jsonls")
M.gopls = require("core.plugins.lsp.settings.gopls")
M.templ = require("core.plugins.lsp.settings.templ")
-- M.yaml = require("core.plugins.lsp.settings.yaml")
-- M.glsl = require("core.plugins.lsp.settings.glsl")
M.clangd = require("core.plugins.lsp.settings.clangd")

return M
