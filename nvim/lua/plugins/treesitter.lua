return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	opts = {
		auto_install = true,
		endure_installed = {
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
}
