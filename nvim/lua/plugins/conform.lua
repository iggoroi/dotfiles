return {
	"stevearc/conform.nvim",
	name = "Conform",
	event = "BufWritePre *.*",
	opts = {
		formatters_by_ft = {
			typescript = { "prettierd" },
			css = { { "prettierd", "prettier" } },
			html = { { "prettierd", "prettier" } },
			json = { { "prettierd", "prettier" } },
			lua = { "stylua" },
		},
		format_on_save = {
			-- These options will be passed to conform.format()
			timeout_ms = 500,
			lsp_fallback = true,
		},
	},
	keys = {
		{
			"<leader>mp",
			function()
				require("conform").format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 1500,
				})
			end,
			{ "n", "v" },
		},
	},
	config = function(_, opts)
		require("conform").setup(opts)
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",

			callback = function(args)
				require("conform").format({ bufnr = args.buf })
			end,
		})
	end,
}
