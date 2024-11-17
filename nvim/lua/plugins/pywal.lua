return {
	"AlphaTechnolog/pywal.nvim",
	event = "VimEnter",
	dependencies = { "LuaLine" },
	config = function()
		local pywal = require("pywal")
		pywal.setup()
		local lualine = require("lualine")

		lualine.setup({
			options = {
				theme = "pywal-nvim",
			},
		})
		vim.cmd([[colorscheme pywal]])
	end,
}
