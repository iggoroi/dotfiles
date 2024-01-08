return {
    'stevearc/conform.nvim',
    opts = {
        formatters_by_ft = {
            typescript = { "prettierd" },
            css = {{"prettierd", "prettier"}},
            html = {{"prettierd", "prettier"}},
            json = { {"prettierd", "prettier"} },
            lua = { "stylua" },
        },
    },
}
