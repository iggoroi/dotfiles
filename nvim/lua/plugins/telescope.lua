return {
	{
		"nvim-telescope/telescope.nvim",
		name = "Telescope",
		dependencies = { "nvim-lua/plenary.nvim" },
		lazy = true,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		dependencies = { "Telescope" },
		name = "Telescope UI",
		event = "BufReadPre",
		keys = {
			{
				"<leader><space>",
				function()
					require("telescope.builtin").find_files()
				end,
			},
			{
				"<leader>fg",
				function()
					require("telescope.builtin").live_grep()
				end,
			},
			{
				"<leader>fb",
				function()
					require("telescope.builtin").buffers()
				end,
			},
			{
				"<leader>fh",
				function()
					require("telescope.builtin").help_tags()
				end,
			},
		},
		config = function()
			require("telescope").setup({
				defaults = {
					file_ignore_patterns = {
						"zig-cache",
						"zig-out",
						"target",
						"node%_modules",
						"node_modules",
					},
					preview = false,
				},
				pickers = {
					find_files = {
						theme = "dropdown",
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
