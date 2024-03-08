return {
	"nvim-lualine/lualine.nvim",
	name = "LuaLine",
	dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
	event = "VimEnter",
	opts = {
		options = {
			icons_enabled = true,

			component_separators = "",
			section_separators = "",
			disabled_filetypes = {
				statusline = {},

				winbar = {},
			},
			ignore_focus = {},
			always_divide_middle = true,
			globalstatus = false,
			refresh = {
				statusline = 1000,
				tabline = 1000,
				winbar = 1000,
			},
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff", "diagnostics" },
			lualine_c = { { "buffers", mode = 4 } },
			lualine_x = {},
			lualine_y = { "tabs" },
			lualine_z = { "windows" },
		},
		inactive_sections = {
			lualine_a = {},

			lualine_b = {},
			lualine_c = { "filename" },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {},
		winbar = {},
		inactive_winbar = {},
		extensions = {},
	},
}
