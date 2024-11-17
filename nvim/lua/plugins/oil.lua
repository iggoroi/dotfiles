return {
	"stevearc/oil.nvim",
	event = "VimEnter",
	name = "Oil",
	-- Optional dependencies
	dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
	config = function()
		require("oil").setup({
			view_options = {
				-- This function defines what is considered a "hidden" file
				is_hidden_file = function(name, _)
					return vim.startswith(name, ".")
						or name == "node_modules"
						or name == "target"
						or name == "zig-out"
						or name == "zig-cache"
				end,
				-- This function defines what will never be shown, even when `show_hidden` is set
				is_always_hidden = function(name, _)
					return vim.startswith(name, "..")
				end,
			},
			float = {
				-- Padding around the floating window
				max_width = 50,
				max_height = 10,
				border = "rounded",
				win_options = {
					winblend = 0,
				},
				-- This is the config that will be passed to nvim_open_win.
				-- Change values here to customize the layout
				override = function(conf)
					return conf
				end,
			},
		})
	end,
	keys = {
		{ "-", "<CMD>Oil<CR>" },
		{
			"ù",
			function()
				require("oil").toggle_float()
			end,
		},
	},
}
