return {
	"L3MON4D3/LuaSnip",
	name = "LuaSnip",
	event = "BufReadPre *.*",
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
	opts = {
		history = true,
		delete_check_events = "TextChanged",
	},
}
