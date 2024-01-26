return {
  "kylechui/nvim-surround",
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({
      keymaps = {
        normal = "ms",
        normal_cur = "mss",
        normal_line = "mS",
        normal_cur_line = "msS",
      },
      -- Configuration here, or leave empty to use defaults
    })
  end,
}
