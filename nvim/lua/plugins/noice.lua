return {
  "folke/noice.nvim",
  config = function(_, opts)
    require("noice").setup({
      cmdline = {

        view = "cmdline",
      },
    })
    table.insert(opts.routes, {
      filter = {
        event = "notify",
        find = "No information available",
      },
      opts = { skip = true },
    })
  end,
}
