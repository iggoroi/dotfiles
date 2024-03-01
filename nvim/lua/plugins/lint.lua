return {
	"mfussenegger/nvim-lint",
	name = "Lint",
	event = "BufWritePre *.*",
	config = function()
		require("lint").linters_by_ft = {
			lua = { "selene" },
		}

		vim.api.nvim_create_autocmd({ "TextChanged" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
