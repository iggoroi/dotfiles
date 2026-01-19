return {
	{
		"nvim-treesitter/nvim-treesitter",
		name = "Treesitter",
		event = "BufReadPre",
		build = ":TSUpdate",
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		name = "ts-textobjs",
		dependencies = { "Treesitter" },
		event = "BufReadPre",
		opts = {},
		config = function(_, opts)
			require("nvim-treesitter").setup(opts)
			require("nvim-treesitter").install({
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
				"zig",
				"c",
			})
		end,
	},
}
