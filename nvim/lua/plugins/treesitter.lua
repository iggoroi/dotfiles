return {
	{
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
				"teal",
				"json",
				"css",
				"rust",
				"scss",
				"zig",
				"c",
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
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		name = "ts-textobjs",
		dependencies = { "Treesitter" },
		event = "BufReadPre",
		opts = {},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}
