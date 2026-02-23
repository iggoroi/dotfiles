vim.lsp.config["powershell_es"] = {
	cmd = {
		"pwsh",
		"-NoLogo",
		"-NoProfile",
		"-Command",
		[[
      Import-Module PowerShellEditorServices;
      Start-EditorServices `
        -HostName "nvim" `
        -HostProfileId "neovim" `
        -HostVersion 1.0.0 `
        -LogPath "$env:TEMP/powershell_es.log" `
        -LogLevel Error `
        -SessionDetailsPath "$env:TEMP/powershell_es.session.json" `
		-Stdio
    ]],
	},
	filetypes = { "ps1" }
}
vim.lsp.enable("powershell_es")
