vim.lsp.config["zls"] = {
	cmd = { "C:\\Users\\Giorgio\\Documents\\zls\\zig-out\\bin\\zls.exe" },
	filetypes = { "zig" },
	root_markers = { "build.zig" },
	settings = {
		zls = {
			zig_exe_path = "C:\\Users\\Giorgio\\Documents\\ZigUp\\zig.exe",
		},
	},
}
vim.lsp.enable("zls")
