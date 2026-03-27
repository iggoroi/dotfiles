local fs, uv = vim.fs, vim.uv

local function has(path)
	return uv.fs_stat(path) ~= nil
end

local function find_root(bufnr)
	local fname = vim.api.nvim_buf_get_name(bufnr)
	if fname == "" then
		fname = uv.cwd()
	end

	-- Parti dalla dir del file e sali
	local dir = fs.dirname(fs.normalize(fname))

	-- 1) Root “vera”: dove esiste Angular installato
	local root = fs.root(dir, function(p)
		return has(fs.joinpath(p, "node_modules", "@angular", "core", "package.json"))
	end)
	if root then return root end

	-- 2) Fallback: workspace markers (monorepo)
	root = fs.root(dir, { "angular.json", "nx.json", "pnpm-workspace.yaml", "lerna.json", "rush.json" })
	if root then return root end

	-- 3) Ultimo fallback
	return fs.root(dir, { "package.json", "tsconfig.json" }) or dir
end

vim.lsp.config["ts_ls"] = {
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = { "typescript", "javascript" },
	root_dir = function(b, r)
		r(find_root(b))
	end,
}
vim.lsp.enable("ts_ls")
