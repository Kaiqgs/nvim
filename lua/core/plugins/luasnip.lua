local M = {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    dependencies = {
        "rafamadriz/friendly-snippets",
    },
    build = "make install_jsregexp",
    config = function()
        local ls = require("luasnip")
        -- local vsc = require("luasnip.loaders.from_vscode")
        local lua = require("luasnip.loaders.from_lua")

        snip_env = {
            s = require("luasnip.nodes.snippet").S,
            sn = require("luasnip.nodes.snippet").SN,
            t = require("luasnip.nodes.textNode").T,
            f = require("luasnip.nodes.functionNode").F,
            i = require("luasnip.nodes.insertNode").I,
            c = require("luasnip.nodes.choiceNode").C,
            d = require("luasnip.nodes.dynamicNode").D,
            r = require("luasnip.nodes.restoreNode").R,
            l = require("luasnip.extras").lambda,
            rep = require("luasnip.extras").rep,
            p = require("luasnip.extras").partial,
            m = require("luasnip.extras").match,
            n = require("luasnip.extras").nonempty,
            dl = require("luasnip.extras").dynamic_lambda,
            fmt = require("luasnip.extras.fmt").fmt,
            fmta = require("luasnip.extras.fmt").fmta,
            conds = require("luasnip.extras.expand_conditions"),
            types = require("luasnip.util.types"),
            events = require("luasnip.util.events"),
            parse = require("luasnip.util.parser").parse_snippet,
            ai = require("luasnip.nodes.absolute_indexer"),
        }

        ls.config.set_config({ history = true, updateevents = "TextChanged,TextChangedI" })

        local function fn(
            args, -- text from i(2) in this example i.e. { { "456" } }
            parent, -- parent snippet or parent node
            user_args -- user_args from opts.user_args
        )
            return user_args:format(tostring(args[1][1]))
        end
        ls.add_snippets("lua", {
            ls.snippet({ trig = "re", name = "require", desc = "adds require for module" }, {
                ls.text_node("local "),
                ls.insert_node(1, "reqfile"),
                ls.text_node(' = require("'),
                ls.insert_node(2, "main"),
                ls.function_node(fn, { 1 }, { user_args = { '.%s")' } }),
                ls.text_node({ "", "" }),
            }),
            ls.snippet({ trig = "rc", name = "require_common", desc = "require specific for defold common" }, {
                ls.text_node("local "),
                ls.insert_node(1, "reqfile"),
                ls.function_node(fn, { 1 }, { user_args = { ' = require("common.%s")' } }),
                ls.text_node({ "", "" }),
            }),

            ls.snippet({ trig = "transition", name = "transition", desc = "fsm transition" }, {
                ls.text_node(":transition(states[s."),
                ls.insert_node(1, "state_a"),
                ls.text_node("], states[s."),
                ls.insert_node(2, "state_b"),
                ls.text_node({ "])" }),
            }),

            ls.snippet({ trig = "localM", name = "new module", desc = "creates a new empty lua module" }, {
                ls.text_node({ "local M = {}", "return M" }),
            }),

            ls.snippet({ trig = "newfsm", name = "finite state machine", desc = "creates new fsm" }, {
                ls.text_node({

                    'local s = { start = "" }',
                    "util.key_mirror(s)",
                    "local states = { [s.start] = fsb.FiniteStateBuilder(s.start):build() }",
                    "local state_machine = fsm.FiniteStateMachine({ states = states }):start(states[s.start], {})",
                    "return state_machine",
                }),
            }),

            ls.snippet({ trig = "newstate", name = "new state", desc = "creates new state" }, {
                ls.text_node("[s."),
                ls.insert_node(1, "state"),
                -- :build()
                ls.function_node(fn, { 1 }, { user_args = { "] = fsb.FiniteStateBuilder(s.%s)" } }),
                ls.insert_node(2, ""),
                ls.text_node({ ":build()" }),
                -- [s.chill] = fsb.FiniteStateBuilder(s.chill):build(),
            }),

            ls.snippet({ trig = "predto", name = "predicate to", desc = "builds new predicate to state" }, {
                ls.text_node(":predicate_to(s."),
                ls.insert_node(1, "state"),
                ls.text_node(", "),
                ls.insert_node(2, "function(self, otherstate) end"),
                ls.text_node({ ")" }),
            }),
        })
        -- load lua snippets
        -- TODO: alternative for Windows
        -- lua.load({ paths = os.getenv("HOME") .. "/.config/nvim/snippets/" })
        -- load friendly-snippets
        -- this must be loaded after custom snippets or they get overwritte!
        -- https://github.com/L3MON4D3/LuaSnip/blob/b5a72f1fbde545be101fcd10b70bcd51ea4367de/Examples/snippets.lua#L497
        -- vsc.lazy_load()
        lua.lazy_load()
        -- expansion key
        -- this will expand the current item or jump to the next item within the snippet.
        vim.keymap.set({ "i", "s" }, "<c-j>", function()
            if ls.expand_or_jumpable() then
                ls.expand_or_jump()
            end
        end, { silent = true })

        -- jump backwards key.
        -- this always moves to the previous item within the snippet
        vim.keymap.set({ "i", "s" }, "<c-k>", function()
            if ls.jumpable(-1) then
                ls.jump(-1)
            end
        end, { silent = true })

        -- selecting within a list of options.
        vim.keymap.set("i", "<c-h>", function()
            if ls.choice_active() then
                ls.change_choice(1)
            end
        end)
    end,
}

return M
