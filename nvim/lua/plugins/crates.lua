return {
	"Saecki/crates.nvim",
	name = "Crates",
	event = { "BufRead Cargo.toml" },
	config = function()
		require("crates").setup({
			src = {
				cmp = { enabled = true },
			},
		})
		require("cmp").setup.buffer({
			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "path" },
				{ name = "crates" },
			},
		})
	end,
}
