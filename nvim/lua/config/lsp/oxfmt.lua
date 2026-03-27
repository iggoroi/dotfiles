vim.lsp.config["oxfmt"] = {
	cmd = { 'oxfmt', '--lsp' },
	filetypes = {
		'javascript',
		'javascriptreact',
		'javascript.jsx',
		'typescript',
		'typescriptreact',
		'typescript.tsx',
		'toml',
		'json',
		'jsonc',
		'json5',
		'yaml',
		'html',
		'vue',
		'handlebars',
		'hbs',
		'css',
		'scss',
		'less',
		'graphql',
		'markdown',
		'mdx',
	},
	workspace_required = true,
	root_markers = { ".oxfmtrc.json", "package.json" }
}
vim.lsp.enable("oxfmt")
