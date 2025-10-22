local luasnip = require("luasnip")

local function fn(
    args, -- text from i(2) in this example i.e. { { "456" } }
    parent, -- parent snippet or parent node
    user_args -- user_args from opts.user_args
)
    return user_args:format(tostring(args[1][1]))
end

local ls = ls or luasnip

local go_snippets = {

    ls.snippet({
        trig = "iferr",
        name = "if error != nil",
        desc = "inlines a ne if err",
    }, {
        ls.text_node({ "if err != nil {", "\treturn " }),
        ls.insert_node(1, "params"),
        ls.text_node({ "", "}" }),
    }),
}

return go_snippets
