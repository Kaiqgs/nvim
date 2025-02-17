local nls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

nls.setup({
    sources = {
        require("none-ls.diagnostics.eslint_d"),
        nls.builtins.formatting.prettierd,
        -- .with({
        --   extra_args = { "--single-quote", "true", "--no-bracket-spacing" },
        --   extra_args = { "--single-quote", "true", "--no-bracket-spacing", "--tab-width", "2", "--use-tabs", "false" },
        -- })
        nls.builtins.formatting.stylua.with({
            extra_args = {
                "--config-path",
                vim.fn.expand("/home/kags/.config/stylua/stylua.toml"),
                "--indent-type",
                "Spaces",
                "--indent-width",
                "4",
            },
        }),

        nls.builtins.formatting.djlint,
        nls.builtins.formatting.black,
        nls.builtins.code_actions.gitsigns,
        nls.builtins.formatting.shfmt,
    },
    on_attach = function(client, bufnr)
        vim.keymap.set(
            "n",
            "<leader>tF",
            "<cmd>lua require('core.plugins.lsp.utils').toggle_autoformat()<cr>",
            { desc = "Toggle format on save" }
        )
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    if AUTOFORMAT_ACTIVE then -- global var defined in functions.lua
                        vim.lsp.buf.format({ bufnr = bufnr })
                    end
                end,
            })
        end
    end,
})
