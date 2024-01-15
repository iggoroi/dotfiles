return {
	"neovim/nvim-lspconfig",
	name = "Lspconfig",
	dependencies = {
		"Mason",
		"Mason Lspconfig",
		"cmp",
	},
	event = "BufReadPre *.*",
	config = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		vim.g.rustaceanvim = {
			-- Plugin configuration
			tools = {},
			-- LSP configuration
			server = {
				capabilities = capabilities,
				on_attach = function(_, bufnr)
					vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

					local bufopts = { noremap = true, silent = true, buffer = bufnr }
					vim.keymap.set("n", "<leader>ca", function()
						vim.cmd.RustLsp("codeAction")
					end, bufopts)
					vim.keymap.set("n", "K", function()
						vim.cmd.RustLsp({ "hover", "actions" })
					end, bufopts)
					vim.keymap.set("v", "K", function()
						vim.cmd.RustLsp({ "hover", "range" })
					end, bufopts)
					vim.keymap.set("n", "<leader>ce", function()
						vim.cmd.RustLsp("explainError")
					end, bufopts)
					vim.keymap.set("n", "<leader>rn", "<CMD>RustLsp ssr<CR>", bufopts)
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
					vim.keymap.set("n", "<C-h>", vim.lsp.buf.signature_help, bufopts)
					vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
				end,
				standalone = false,
				settings = {
					-- rust-analyzer language server configuration
					["rust-analyzer"] = {
						checkOnSave = {
							command = "clippy",
						},
					},
				},
			},
		}
	end,
}
