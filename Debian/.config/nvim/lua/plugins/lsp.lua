return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "stylua",
        "selene",
        "luacheck",
        "shellcheck",
        "shfmt",
        "tailwindcss-language-server",
        "rust-analyzer",
        "angular-language-server",
        "prettier",
        "google-java-format",
        "jdtls",
      })
    end,
  },
}
