return { 
    "mason-org/mason-lspconfig.nvim",
    opts = {
        ensure_installed = {
            "lua_ls",
            "pyright",
            "ts_ls",
            "rust_analyzer",
            "clangd",
            "sqls",
            "qmlls"
        },

    },

}

