return {
	"mfussenegger/nvim-lint",
	name = "Lint",
	event = "BufWritePre *.*",
	config = function()
		require("lint").linters_by_ft = {
			lua = { "selene" },
			typescript = { "oxlint" },
			ts = { "oxlint" },
			javascript = { "oxlint" },
			js = { "oxlint" },
		}

		vim.api.nvim_create_autocmd({ "TextChanged" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
