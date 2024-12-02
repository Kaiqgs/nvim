local ls = require("luasnip")
local function fn(
	args, -- text from i(2) in this example i.e. { { "456" } }
	parent, -- parent snippet or parent node
	user_args -- user_args from opts.user_args
)
	return user_args:format(tostring(args[1][1]))
end

return {

	-- ls.snippet({
	--     trig = "local function ",
	--     name = "self parametered function",
	--     desc = "creates a function with self parameter",
	-- }, {

	-- ---@param self RestartController
	-- function draw_environment()
	-- }),

	-- new
	-- ls.snippet({
	--
	-- })
}
