-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

--luasnip angular snippets
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets/angular" } })
