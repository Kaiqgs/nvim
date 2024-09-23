local utils = require("utils.functions")
local inspect = require("utils.inspect")
-- local dap = require("dap")
local map = vim.keymap.set

--- Lua snip suggested
vim.api.nvim_set_keymap("i", "<C-n>", "<Plug>luasnip-jump-next", {})
vim.api.nvim_set_keymap("i", "<C-p>", "<Plug>luasnip-jump-prev", {})
---

--- two functions below are the worst code Ive ever written
local function todo_abstract()
    local luasnip = require("luasnip")
    -- luasnip.load()
    local snippets = luasnip.get_snippets("all")
    local itercount = 0
    local mysnip
    for _, snip in pairs(snippets) do
        if snip.name == "require_common" then
            mysnip = snip
            break
        end
        -- print(snipkey)
        -- print(snip.name or "namelessbitch")
        -- -- print(inspect.inspect(snip))
        -- print("a-----------a")
        itercount = itercount + 1
    end
    if not mysnip then
        print("warn: no snip")
        return
    end
    local pos = vim.fn.getpos(".")
    local group = "requirx"
    luasnip.snip_expand(mysnip, {
        pos = { 0, 0 },
    })
    vim.api.nvim_create_augroup(group, {
        clear = true,
    })
    vim.api.nvim_create_autocmd("InsertEnter", {
        group = group,
        callback = function()
            vim.api.nvim_create_autocmd("InsertLeave", {
                group = group,
                callback = function()
                    pos[2] = pos[2] + 1
                    -- pos[3] = pos[3] + 1
                    -- print("bro got back? w/ pos")
                    -- print(inspect.inspect(pos))
                    vim.api.nvim_cmd({ cmd = "startinsert" }, {})
                    vim.fn.setpos(".", pos)

                    -- vim.cmd("startinsert")
                    -- vim.api.nvim_parse_cmd("startinsert", {})
                    -- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("i"), )
                    vim.api.nvim_del_augroup_by_name(group)
                end,
            })
        end,
    })
end

local function copy_paste_changed()
    local luasnip = require("luasnip")
    -- luasnip.load()
    local snippets = luasnip.get_snippets("all")
    local itercount = 0
    local mysnip
    for _, snip in pairs(snippets) do
        if snip.name == "require" then
            mysnip = snip
            break
        end
        -- print(snipkey)
        -- print(snip.name or "namelessbitch")
        -- -- print(inspect.inspect(snip))
        -- print("a-----------a")
        itercount = itercount + 1
    end
    if not mysnip then
        print("warn: no snip")
        return
    end
    local pos = vim.fn.getpos(".")
    local group = "requirx"
    luasnip.snip_expand(mysnip, {
        pos = { 0, 0 },
    })
    vim.api.nvim_create_augroup(group, {
        clear = true,
    })
    vim.api.nvim_create_autocmd("InsertEnter", {
        group = group,
        callback = function()
            vim.api.nvim_create_autocmd("InsertLeave", {
                group = group,
                callback = function()
                    vim.api.nvim_create_autocmd("InsertEnter", {
                        group = group,
                        callback = function()
                            vim.api.nvim_create_autocmd("InsertLeave", {
                                group = group,
                                callback = function()
                                    pos[2] = pos[2] + 1
                                    -- print("bro got back? w/ pos")
                                    -- print(inspect.inspect(pos))
                                    vim.api.nvim_cmd({ cmd = "startinsert" }, {})
                                    vim.fn.setpos(".", pos)
                                    vim.api.nvim_del_augroup_by_name(group)
                                end,
                            })
                        end,
                    })
                end,
            })
        end,
    })
end

-- colemak dh remap
-- map("n", "h", "n", { noremap = true })
-- map("n", "j", "e", { noremap = true })
-- map("n", "k", "i", { noremap = true })
-- map("n", "l", "o", { noremap = true })

--- super crazy lua require
-- map("i", "<C-X>", "<Esc>gg<S-O>re<Tab><cr>", { desc = "Lua Require"})
map("i", "<C-X>", todo_abstract, { desc = "Lua Common Require" })
map("i", "<C-Z>", copy_paste_changed, { desc = "Lua Require" })

-- Insert:
map("i", "<C-I>", "<Esc>cc", { desc = "[C]lear [I]ndent" })

-- Actions:
map("n", "<bs>", "<c-^>'\"zz", { desc = "Toggle buffer" })
map("n", "<tab>", "<Cmd>Telescope buffers<cr>", { desc = "Previous buffer" })
-- map("n", "<tab>", "<Cmd>bprevious<cr>", { desc = "Previous buffer" })
-- map("n", "<S-tab>", "<Cmd>bnext<cr>", { desc = "Next buffer" })
map("v", "=", "gq", { desc = "Format selection" })
map("n", "<leader>wa", "<Cmd>tabd w<cr><Cmd>wa<cr>", { desc = "Write all buffers" })
map("n", "<leader>f", vim.lsp.buf.format, { desc = "Format buffer" })
map("n", "<leader>ww", "<Cmd>w!<cr>", { desc = "Write buffer" })
map("n", "<leader>e", "<Cmd>Explore<cr>", { desc = "Open explore" })
map("n", "<leader>q", "<Cmd>bd<cr>", { desc = "Close buffer" })
map("n", "<leader>cf", "<Cmd>CloseFloatingWindows<cr>", { desc = "[C]lose [F]loating Windows" })
map("n", "<leader>cw", "", { desc = "[C]urrent [W]orking Directory" })
map("n", "<leader>te", "<Cmd>terminal<cr>", { desc = "[T][e]rminal" })
map("n", "<C-I>", "cc", { desc = "[C]lear [I]ndent" })
map("n", "<leader>nh", "<Cmd>noh<cr>", { desc = "[N]o [H]ighlight" })
map("n", "<leader>S", "<Cmd>Spectre<cr>", { desc = "[S]pectre" })
map("n", "<leader>ec", "<Cmd>Copilot enable<cr>", { desc = "[E]nable [C]opilot" })

-- project nvim
map("n", "<leader>pr", "<Cmd>ProjectRoot<cr>", { desc = "Set [P]roject [R]oot" })

--auto-save
map("n", "<leader>as", "<Cmd>ASToggle<CR>", { desc = "Toggle [A]uto-[S]ave" })

-- no-yanking
map("x", "<leader>p", [["_dP]], { desc = "[P]aste without yanking" })
map("x", "<leader>d", [["_d]], { desc = "[D]elete without yanking" })
map("x", "<leader>c", [["_c]], { desc = "[C]hange without yanking" })
map("x", "<leader>cc", [["_cc"]], { desc = "[C]hange [C]urrent Line" })
map("x", "<leader>dd", [["_dd]], { desc = "[D]elete [D]irect" })

-- toggles
map("n", "<leader>ta", "<Cmd>ASToggle<CR>", { desc = "[T]oggle [A]uto-save" })
map("n", "<leader>ts", utils.toggle_strip_space, { desc = "[T]oggle [S]trip Whitespace" })

--diffview
-- map("n", "<leader>go", require("diffview").open, { silent = true })
-- map("n", "<leader>gc", require("diffview").close, { silent = true })

-- diagnostics
map("n", "[d", vim.diagnostic.goto_prev)
map("n", "]d", vim.diagnostic.goto_next)
map("n", "<leader>de", vim.diagnostic.open_float)
map("n", "<leader>dq", vim.diagnostic.setloclist)

-- telescope
map("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
map("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
map("n", "<leader>/", function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
    }))
end, { desc = "[/] Fuzzily search in current buffer]" })

map("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
map("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
map("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
map("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
map("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })

local function DM(m)
    return string.format("DAP: %s", m)
end
-- dap
map("n", "<F4>", function()
    require("dap").terminate()
end, { desc = DM("Terminate") })

map("n", "<F5>", function()
    require("dap").continue()
end, { desc = "Continue" })
map("n", "<F6>", function()
    require("dap").step_over()
end, { desc = " " })
map("n", "<F7>", function()
    require("dap").step_into()
end)
map("n", "<F8>", function()
    require("dap").step_out()
end)
map("n", "<Leader>b", function()
    require("dap").toggle_breakpoint()
end)
map("n", "<Leader>B", function()
    require("dap").set_breakpoint()
end)
map("n", "<Leader>lp", function()
    require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end)
map("n", "<Leader>dr", function()
    require("dap").repl.open()
end)
map("n", "<Leader>dl", function()
    require("dap").run_last()
end)
map({ "n", "v" }, "<Leader>dh", function()
    require("dap.ui.widgets").hover()
end)
map({ "n", "v" }, "<Leader>dp", function()
    require("dap.ui.widgets").preview()
end)
map("n", "<Leader>df", function()
    local widgets = require("dap.ui.widgets")
    widgets.centered_float(widgets.frames)
end)
map("n", "<Leader>do", function()
    require("dapui").open()
end)
map("n", "<Leader>dc", function()
    require("dapui").close()
end)

--- LuaPad

map("n", "<Leader>L", function()
    require("luapad").toggle()
end)

map("n", "<Leader>lu", "<Cmd>Luapad<CR>", { desc = "LuaPad Eval" })

-- map("n",  "<Leader>Li", function()
--     local luapad = require("luapad")
--     local user_input = vim.fn.input("LuaPad: ")
--     luapad.
-- end)

-- 7. bind <leader>wt to open vimwiki index;
-- map("n", "<leader>wt", "<Plug>VimwikiTabIndex", { silent = true })
-- map("n", "<space>ww", "", {})
-- map('n', '<space>wo', '<cmd>VimwikiIndex<CR>', { noremap = true, silent = true })

-- 8. bind <leader>xx to toggle list item;
-- map("n", "<leader>xx", "<Plug>VimwikiToggleListItem", { silent = true })
-- 9. bind insert-mode <S-tab> to go to VimwikiTableNextCell;
-- map("i", "<S-tab>", "<Plug>VimwikiTableNextCell", { silent = true })
-- 10. bind B to go to VimwikiGoBackLink;
-- map("n", "<leader>wb", "<Plug>VimwikiGoBackLink", { silent = true })
-- 11. bind <leader>w to write;
-- 12. bind <leader>go to DiffviewOpen;
-- 13. bind <leader>gc to DiffviewClose;
-- 14. bind <leader>e to open/close explore;
-- 15. bind <leader>q to close buffer;

--
-- local mapping = {
--   { "n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true } },
-- }
--
-- -- Remap for dealing with visual line wraps
-- map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
-- map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
--
-- -- better indenting
-- map("v", "<", "<gv")
-- map("v", ">", ">gv")
--
-- -- paste over currently selected text without yanking it
-- map("v", "p", '"_dp')
-- map("v", "P", '"_dP')
--
-- -- buffers
-- map("n", "<tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
-- map("n", "<S-tab>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
-- map("n", "<leader>bD", "<cmd>%bd|e#|bd#<cr>", { desc = "Close all but the current buffer" })
-- map("n", "<leader>bd", "<cmd>Bdelete<cr>", { desc = "Close buffer" })
-- map("n", "<leader><tab>", "<cmd>e#<cr>", { desc = "Previous Buffer" }) -- TODO: better desc
--
-- -- Cancel search highlighting with ESC
-- map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Clear hlsearch and ESC" })
--
-- -- move over a closing element in insert mode
-- map("i", "<C-l>", function()
--   return require("utils.functions").escapePair()
-- end)
--
-- -- save like your are used to
-- map({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
--
-- -- new file
-- map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New file" })
-- -- save file
-- map("n", "<leader>fs", "<cmd>w<cr>", { desc = "Save file" })
--
-- -- search and replace is a pain with a German keyboard layout
-- map({ "v", "n" }, "<leader>sr", ":%s/", { desc = "Buffer search and replace" })
--
-- -- toggles
-- map("n", "<leader>tn", function()
--   vim.o.number = vim.o.number == false and true or false
--   vim.o.relativenumber = vim.o.relativenumber == false and true or false
-- end, { desc = "Toggle number" })
-- map("n", "<leader>th", function()
--   utils.notify("Toggling hidden chars", vim.log.levels.INFO, "core.mappings")
--   vim.o.list = vim.o.list == false and true or false
-- end, { desc = "Toggle hidden chars" })
-- map("n", "<leader>tl", function()
--   utils.notify("Toggling signcolumn", vim.log.levels.INFO, "core.mappings")
--   vim.o.signcolumn = vim.o.signcolumn == "yes" and "no" or "yes"
-- end, { desc = "Toggle signcolumn" })
-- map("n", "<leader>tv", function()
--   utils.notify("Toggling virtualedit", vim.log.levels.INFO, "core.mappings")
--   vim.o.virtualedit = vim.o.virtualedit == "all" and "block" or "all"
-- end, { desc = "Toggle virtualedit" })
-- map("n", "<leader>ts", function()
--   utils.notify("Toggling spell", vim.log.levels.INFO, "core.mappings")
--   vim.o.spell = vim.o.spell == false and true or false
-- end, { desc = "Toggle spell" })
-- map("n", "<leader>tw", function()
--   utils.notify("Toggling wrap", vim.log.levels.INFO, "core.mappings")
--   vim.o.wrap = vim.o.wrap == false and true or false
-- end, { desc = "Toggle wrap" })
-- map("n", "<leader>tc", function()
--   utils.notify("Toggling cursorline", vim.log.levels.INFO, "core.mappings")
--   vim.o.cursorline = vim.o.cursorline == false and true or false
-- end, { desc = "Toggle cursorline" })
-- map("n", "<leader>to", "<cmd>lua require('utils.functions').toggle_colorcolumn()<cr>", { desc = "Toggle colorcolumn" })
-- map(
--   "n",
--   "<leader>tt",
--   "<cmd>lua require('core.plugins.lsp.utils').toggle_virtual_text()<cr>",
--   { desc = "Toggle Virtualtext" }
-- )
-- map("n", "<leader>tS", "<cmd>windo set scb!<cr>", { desc = "Toggle Scrollbind" })
--
-- -- Reload snippets folder
-- -- TODO make path system independent
-- map("n", "<leader>ms", "<cmd>source ~/.config/nvim/snippets/*<cr>", { desc = "Reload snippets" })
--
-- -- Quickfix
-- map("n", "<leader>qj", "<cmd>cnext<cr>", { desc = "Next entry" })
-- map("n", "<leader>qk", "<cmd>cprevious<cr>", { desc = "Previous entry" })
-- map("n", "<leader>qq", "<cmd>lua require('utils.functions').toggle_qf()<cr>", { desc = "Toggle Quickfix" })
-- -- Search for 'FIXME', 'HACK', 'TODO', 'NOTE'
-- map("n", "<leader>qt", function()
--   utils.search_todos()
-- end, { desc = "List TODOs" })
