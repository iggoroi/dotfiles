---@diagnostic disable: undefined-global
local capabilities = require("cmp_nvim_lsp").default_capabilities()
opts = {
    ensure_installed = {
        "stylua",
        "selene",
        "luacheck",
        "shellcheck",
        "shfmt",
        "prettier",
        "google-java-format",
        "jdtls",
    },
}
require("mason").setup(opts)
local mr = require("mason-registry")
mr:on("package:install:success", function()
    vim.defer_fn(function()
        require("lazy.core.handler.event").trigger({

            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
        })
    end, 100)
end)
local function ensure_installed()
    for _, tool in ipairs(opts.ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
            p:install()
        end
    end
end
if mr.refresh then
    mr.refresh(ensure_installed)
else
    ensure_installed()
end

require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "angularls",
        "tsserver",
        "html",
        "cssls",
        "eslint",
        "rust_analyzer",
    },
    automatic_installation = { exclude = { "rust_analyzer", "solargraph" } },
})

require("lspconfig").angularls.setup({
    capabilities = capabilities,
})
require("lspconfig").tsserver.setup({
    capabilities = capabilities,
})
require("lspconfig").html.setup({
    capabilities = capabilities,
})
require("lspconfig").lua_ls.setup({
    capabilities = capabilities,
})
require("lspconfig").cssls.setup({
    capabilities = capabilities,
})
require("lspconfig").rust_analyzer.setup({
    capabilities = capabilities,
})
