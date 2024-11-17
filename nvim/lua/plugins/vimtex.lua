return {
	"lervag/vimtex",
	name = "VimTeX",
	filetype = { "tex" },
	config = function(_)
		vim.cmd([[
            let g:vimtex_view_general_viewer = 'SumatraPDF'
            let g:vimtex_view_general_options
                \ = '-reuse-instance -forward-search @tex @line @pdf'
        ]])
	end,
}
