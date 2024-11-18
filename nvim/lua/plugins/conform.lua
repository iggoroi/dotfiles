return {
	"stevearc/conform.nvim",
	name = "Conform",
	event = "BufWritePre *.*",
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
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				zig = { "zigfmt" },
				javascript = { "prettierd", "prettier" },
				html = { "prettierd", "prettier" },
				css = { "prettierd", "prettier" },
				rust = { "leptosfmt" },
			},
			formatters = {
				leptosfmt = {
					-- This can be a string or a function that returns a string.
					-- When defining a new formatter, this is the only field that is required
					command = "leptosfmt",
					-- A list of strings, or a function that returns a list of strings
					-- Return a single string instead of a list to run the command in a shell
					args = { "--stdin", "--rustfmt" },
					-- If the formatter supports range formatting, create the range arguments here
					-- range_args = function(self, ctx) end,
					-- Send file contents to stdin, read new contents from stdout (default true)
					-- When false, will create a temp file (will appear in "$FILENAME" args). The temp
					-- file is assumed to be modified in-place by the format command.
					stdin = true,
					-- A function that calculates the directory to run the command in
					cwd = require("conform.util").root_file({ "cargo.toml" }),
					-- When cwd is not found, don't run the formatter (default false)
					require_cwd = true,
					-- When stdin=false, use this template to generate the temporary file that gets formatted
					tmpfile_format = ".conform.$RANDOM.$FILENAME",
					-- When returns false, the formatter will not be used
					condition = function(self, ctx)
						return vim.fs.basename(ctx.filename) ~= "README.md"
					end,
					-- Exit codes that indicate success (default { 0 })
					exit_codes = { 0 },
					-- Environment variables. This can also be a function that returns a table.
					-- env = {},
					-- Set to false to disable merging the config with the base definition
					inherit = true,
					-- When inherit = true, add these additional arguments to the command.
					-- This can also be a function, like args
					-- prepend_args = { "--use-tabs" },
				},
			},
			format_on_save = {
				-- These options will be passed to conform.format()
				timeout_ms = 500,
				lsp_fallback = true,
			},
		})
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",

			callback = function(args)
				require("conform").format({ bufnr = args.buf })
			end,
		})
	end,
}
