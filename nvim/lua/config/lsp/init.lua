vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		vim.api.nvim_buf_set_option(args.buf, "omnifunc", "v:lua.vim.lsp.omnifunc")

		local bufopts = { noremap = true, silent = true, buffer = args.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
		vim.keymap.set({ "n", "i" }, "<C-h>", vim.lsp.buf.signature_help, bufopts)
		vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, bufopts)
		vim.keymap.set({ "n", "v" }, "<leader>cA", function()
			vim.lsp.buf.code_action({
				context = {
					only = {
						"source",
					},
					diagnostics = {},
				},
			})
		end, bufopts)
	end,
})
pcall(vim.keymap.del, { "n", "v" }, "gra", bufopts)
pcall(vim.keymap.del, { "n", "v" }, "gri", bufopts)
pcall(vim.keymap.del, { "n", "v" }, "grn", bufopts)
pcall(vim.keymap.del, { "n", "v" }, "grr", bufopts)
pcall(vim.keymap.del, { "n", "v" }, "grt", bufopts)
pcall(vim.keymap.del, { "n", "v" }, "gO", bufopts)
pcall(vim.keymap.del, { "i" }, "C-s", bufopts)
pcall(vim.keymap.del, { "v" }, "an", bufopts)
pcall(vim.keymap.del, { "n", "v" }, "grt", bufopts)
pcall(vim.keymap.del, { "n", "v" }, "gO", bufopts)
pcall(vim.keymap.del, { "i" }, "C-s", bufopts)
pcall(vim.keymap.del, { "v" }, "an", bufopts)
pcall(vim.keymap.del, { "v" }, "in", bufopts)
pcall(vim.keymap.del, { "n" }, "K", bufopts)
pcall(vim.keymap.del, { "v" }, "in", bufopts)
pcall(vim.keymap.del, { "n" }, "K", bufopts)

local capabilities = require("config.lsp.capabilities").make()

vim.lsp.config("*", {
	capabilities = capabilities
})

require("config.lsp.angularls")
require("config.lsp.lua_ls")
require("config.lsp.zls")
require("config.lsp.cssls")
require("config.lsp.powershell_es")
require("config.lsp.ts_ls")
require("config.lsp.jdtls")
require("config.lsp.postgres")
require("config.lsp.oxfmt")
require("config.lsp.oxlint")
