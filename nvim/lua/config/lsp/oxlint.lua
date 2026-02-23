vim.lsp.config["oxfmt"] = {
	cmd = { 'oxfmt', '--lsp' },
	filetypes = {
		'javascript',
		'javascriptreact',
		'javascript.jsx',
		'typescript',
		'typescriptreact',
		'typescript.tsx',
		'vue',
		'svelte',
		'astro',
	},
	workspace_required = true,
	root_markers = { ".oxfmtrc.json", "package.json" },
	init_options = {
		settings = {
			-- ['run'] = 'onType',
			-- ['configPath'] = nil,
			-- ['tsConfigPath'] = nil,
			-- ['unusedDisableDirectives'] = 'allow',
			-- ['typeAware'] = false,
			-- ['disableNestedConfig'] = false,
			-- ['fixKind'] = 'safe_fix',
		},
	},
}
vim.lsp.enable("oxfmt")
