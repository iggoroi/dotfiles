return {
	"ellisonleao/gruvbox.nvim",
	name = "Gruvbox",
	event = "VimEnter",
	priority = 1000,
	config = function()
		vim.cmd([[colorscheme gruvbox]])
	end,
}
