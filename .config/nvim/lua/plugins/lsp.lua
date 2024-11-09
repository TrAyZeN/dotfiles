return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            lspconfig.clangd.setup({
                filetypes = { "c", "h", "cpp", "hpp", "cc", "hh", "hxx" },
                capabilities = capabilities,
            })

            lspconfig.pyright.setup({ capabilities = capabilities })

            lspconfig.verible.setup({ capabilities = capabilities })
        end,
    },
}
