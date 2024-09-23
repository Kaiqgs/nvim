-- local M = {
--   "lewis6991/gitsigns.nvim",
--   event = { "BufReadPre", "BufNewFile" },
--   dependencies = {
--     "nvim-lua/plenary.nvim",
--   },
--   config = function()
--     local function mappings()
--       local wk = require("which-key")
--       local default_options = { silent = true }
--       local gs = package.loaded.gitsigns
--       local map = require("utils.functions").map
--
--       wk.register({
--         g = {
--           name = "Git",
--           M = { "Hydra move" },
--           ["<Enter>"] = { "<cmd>lua require('neogit').open()<cr>", "Neogit" },
--           c = { "<cmd>G commit %<cr>", "Commit buffer" },
--           P = { "<cmd>G push<cr>", "Push" },
--           S = { gs.stage_buffer, "Stage buffer" },
--           u = { gs.undo_stage_hunk, "Undo stage hunk" },
--           r = {
--             name = "Reset",
--             R = { gs.reset_buffer, "Reset buffer" },
--           },
--           p = { gs.preview_hunk, "Preview hunk" },
--           B = {
--             function()
--               gs.blame_line({ full = true })
--             end,
--             "Blame full",
--           },
--           b = { gs.toggle_current_line_blame, "Blame line" },
--           D = { gs.diffthis, "Diff" },
--           d = { gs.toggle_deleted, "Show deleted" },
--         },
--       }, { prefix = "<leader>", mode = "n", default_options })
--
--       -- TODO: with german qwertz this bindings are awful
--
--       map({ "n", "v" }, "<leader>grr", "<cmd>Gitsigns reset_hunk<cr>", { desc = "Reset hunk" })
--       map({ "n", "v" }, "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>", { desc = "Stage hunk" })
--       map({ "o", "x" }, "gH", "<cmd><C-U>Gitsigns select_hunk<cr>", { desc = "Select hunk" })
--     end
--     require("gitsigns").setup({
--
--       signs = {
--         add = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
--         change = { hl = "GitSignsChange", text = "│", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
--         delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
--         topdelete = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
--         changedelete = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
--       },
--       signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
--       numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
--       linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
--       word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
--       watch_gitdir = {
--         interval = 1000,
--         follow_files = true,
--       },
--       attach_to_untracked = true,
--       current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
--       current_line_blame_opts = {
--         virt_text = true,
--         virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
--         delay = 0,
--         ignore_whitespace = false,
--       },
--       current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
--       sign_priority = 6,
--       update_debounce = 100,
--       status_formatter = nil, -- Use default
--       max_file_length = 40000, -- Disable if file is longer than this (in lines)
--       preview_config = {
--         -- Options passed to nvim_open_win
--         border = "single",
--         style = "minimal",
--         relative = "cursor",
--         row = 0,
--         col = 1,
--       },
--       yadm = {
--         enable = false,
--       },
--     })
--     mappings()
--   end,
-- }
--
-- return M
--

local user_config = vim.g.config.plugins.gitsigns or {}

local default_config = {
    enabled = true,
    keys = {
        { "<leader>g", "", desc = "+Git" },
    },
    opts = {
        on_attach = function(buffer)
            local gs = package.loaded.gitsigns
            local function map(mode, l, r, desc)
                vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
            end
            -- map("n", "gj", gs.next_hunk, "Git next hunk")
            -- map("n", "gk", gs.prev_hunk, "Git previous hunk")
            map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>", "Stage hunk")
            map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
            map("n", "<leader>gS", gs.stage_buffer, "Stage buffer")
            map("n", "<leader>gu", gs.undo_stage_hunk, "Undo stage hunk")
            map("n", "<leader>gR", gs.reset_buffer, "Reset buffer")
            map("n", "<leader>gp", gs.preview_hunk, "Preview hunk")
            map("n", "<leader>gB", gs.blame, "Blame")
            map("n", "<leader>gb", gs.toggle_current_line_blame, "Blame line")
            map("n", "<leader>gD", gs.diffthis, "Diff")
            map("n", "<leader>ge", gs.toggle_deleted, "toggle [G]it [E]rased")
            map({ "o", "x" }, "gH", "<cmd><C-U>Gitsigns select_hunk<cr>", "Select hunk")

            map("n", "]c", gs.next_hunk, "Git next hunk")
            map("n", "[c", gs.prev_hunk, "Git previous hunk")
        end,
    },
}

local config = vim.tbl_deep_extend("force", default_config, user_config)

return {
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        opts = config.opts,
        keys = config.keys,
        config = function(_, opts)
            require("gitsigns").setup(opts)
        end,
    },
}
