local luasnip = require("luasnip")
local defold = require("utils.defold")

local function extend(t1, t2)
    for _, v in ipairs(t2) do
        table.insert(t1, v)
    end
end

local function fn(
    args, -- text from i(2) in this example i.e. { { "456" } }
    parent, -- parent snippet or parent node
    user_args -- user_args from opts.user_args
)
    return user_args:format(tostring(args[1][1]))
end

local ls = ls or luasnip

local lua_snippets = {
    ls.snippet({
        trig = "@",
        name = "annotation",
        desc = "inlines a new annotation style",
    }, {
        ls.text_node({ "---@" }),
        ls.insert_node(1, "param"),
        ls.text_node(" "),
        ls.insert_node(2, ""),
    }),

    ls.snippet({
        trig = "localM",
        name = "new module",
        desc = "creates a new empty lua module",
    }, {
        ls.text_node({ "local M = {}", "return M" }),
    }),

    ls.snippet({
        trig = "constructor",
        name = "new constructor",
        desc = "initializes class",
    }, {
        ls.text_node("---@class "),
        ls.insert_node(1, "ClassType"),
        ls.text_node({ "", "local " }),
        ls.insert_node(2, "M"),
        ls.text_node({ " = new_class({})", "" }),

        ls.text_node("function "),
        ls.function_node(fn, { 2 }, { user_args = { "%s" } }),
        ls.text_node(":new("),
        ls.insert_node(3, "o"),
        ls.text_node({ ")", "---@class " }),
        -- ls.insert_node(3, "ClassType"),
        ls.function_node(fn, { 1 }, { user_args = { "%s" } }),
        ls.text_node({ "", "\tlocal new = {" }),
        ls.function_node(fn, { 3 }, { user_args = { " %s " } }),

        ls.text_node({
            "}",
            "\treturn setmetatable(new, self)",
            "end",
        }),
    }),

    ls.snippet({
        trig = "method",
        name = "new method",
        desc = "new function for metatable",
    }, {
        ls.text_node("function "),
        ls.insert_node(1, "ClassName"),
        ls.text_node(":"),
        ls.insert_node(2, "method"),
        ls.text_node("("),
        ls.insert_node(3, ""),
        ls.text_node({ ")", "end" }),
    }),
}
if not defold.is_defold_project(vim.api.nvim_buf_get_name(0)) then
    return lua_snippets
end
extend(lua_snippets, {
    ls.snippet({
        trig = "paramself",
        name = "parameter self",
        desc = "Declares the parameter self with type",
    }, {
        ls.text_node("---@param self "),
        ls.insert_node(1, "MyType"),
    }),
    ls.snippet({
        trig = "rc",
        name = "require_common",
        desc = "require specific for defold common",
    }, {
        ls.text_node("local "),
        ls.insert_node(1, "reqfile"),
        ls.function_node(
            fn,
            { 1 },
            { user_args = { ' = require("common.%s")' } }
        ),
        ls.text_node({ "", "" }),
    }),
    ls.snippet({
        trig = "re",
        name = "require",
        desc = "adds require for module",
    }, {
        ls.text_node("local "),
        ls.insert_node(1, "reqfile"),
        ls.text_node(' = require("'),
        ls.insert_node(2, "main"),
        ls.function_node(fn, { 1 }, { user_args = { '.%s")' } }),
        ls.text_node({ "", "" }),
    }),

    ls.snippet({
        trig = "transition",
        name = "transition",
        desc = "fsm transition",
    }, {
        ls.text_node(":transition(s."),
        ls.insert_node(1, "state_a"),
        ls.text_node(", s."),
        ls.insert_node(2, "state_b"),
        ls.text_node({ ")" }),
    }),
    ls.snippet({
        trig = "newfsm",
        name = "finite state machine",
        desc = "creates new fsm",
    }, {
        ls.text_node({

            'local s = util.key_mirror({ start = "" })',
            "local states = { FiniteStateBuilder(s.start):build() }",
            "local state_machine = FiniteStateMachine({ states = states }):start(s.start, {})",
            "return state_machine",
        }),
    }),

    ls.snippet({
        trig = "newstate",
        name = "new state",
        desc = "creates new state",
    }, {
        ls.text_node("FiniteStateBuilder(s."),

        ls.insert_node(1, "state"),
        ls.text_node(")"),
        -- :build()
        ls.insert_node(2, ""),
        ls.text_node({ ":build()" }),
        -- [s.chill] = fsb.FiniteStateBuilder(s.chill):build(),
    }),

    ls.snippet({
        trig = "predto",
        name = "predicate to",
        desc = "builds new predicate to state",
    }, {
        ls.text_node(":predicate_to(s."),
        ls.insert_node(1, "state"),
        ls.text_node(", "),
        ls.insert_node(2, "function(self, otherstate) end"),
        ls.text_node({ ")" }),
    }),
    ls.snippet({
        trig = "property",
        name = "new property",
        desc = "creates a new property",
    }, {

        ls.text_node('go.property("'),
        ls.insert_node(1, "name"),
        ls.text_node('", '),
        ls.insert_node(2, 'hash("")'),
        ls.text_node(")"),
    }),

    -- ls.snippet({
    --     trig = "func%s+(%w+)",
    --     regTrig = true,
    -- }, {
    --     ls.text_node("text snipp"),
    -- }),
})

return lua_snippets
