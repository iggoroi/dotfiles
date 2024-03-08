return {
	"ellisonleao/gruvbox.nvim",
	name = "Gruvbox",
	event = "VimEnter",
	priority = 1000,
	config = function()
		vim.cmd([[colorscheme pywal]])
	end,
}
