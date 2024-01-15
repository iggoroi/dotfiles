return {
	"craftzdog/solarized-osaka.nvim",
	name = "Solarized Osaka",
	event = "VimEnter",
	priority = 1000,
	config = function()
		vim.cmd([[colorscheme Solarized-Osaka]])
	end,
}
