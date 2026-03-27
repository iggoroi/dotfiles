vim.lsp.config["ts_ls"] = {
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = { "typescript", "javascript" },
	root_markers = { "package.json" },
}
vim.lsp.enable("ts_ls")
