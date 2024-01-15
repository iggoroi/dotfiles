return {
	"nvim-treesitter/nvim-treesitter",
	name = "Treesitter",
	event = "BufReadPre",
	opts = {
		ensure_installed = {
			"yaml",
			"toml",
			"html",
			"vim",
			"typescript",
			"javascript",
			"lua",
			"json",
			"css",
			"rust",
			"scss",
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<Enter>",
				node_incremental = "<Enter>",
				node_decremental = "<BS>",
			},
		},
	},
	build = ":TSUpdate",
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
