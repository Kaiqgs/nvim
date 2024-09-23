return {
  "Pocco81/auto-save.nvim",
  config = function()
    require("auto-save").setup({
      -- vim.g.config.plugins.auto_save
      debounce_delay = 1000,
      enabled = true,
        trigger_events = {"InsertLeave"}
    })
  end,
}
