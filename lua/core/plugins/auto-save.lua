
return {
  "Pocco81/auto-save.nvim",
  config = function()
    require("auto-save").setup({
	-- vim.g.config.plugins.auto_save
      enabled = true,
    })
  end,
}

