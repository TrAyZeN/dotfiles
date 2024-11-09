return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            -- source for builtin lsp client
            "hrsh7th/cmp-nvim-lsp",
            -- source for buffer words
            "hrsh7th/cmp-buffer",
            -- source for filesystem paths
            "hrsh7th/cmp-path",
            -- source for vim's cmdline
            "hrsh7th/cmp-cmdline",
            -- source for vim-vsnip
            "hrsh7th/cmp-vsnip",
            -- source for displaying function signatures with current params
            "hrsh7th/cmp-nvim-lsp-signature-help",
        },
        config = function()
            -- Config inspired from
            -- https://github.com/hrsh7th/nvim-cmp/tree/main?tab=readme-ov-file#recommended-configuration
            local cmp = require("cmp")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body)
                    end,
                },
                mapping = {
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.close(),
                    ["<Tab>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Insert,
                        select = true,
                    })
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "vsnip" },
                    { name = "path" },
                    { name = "buffer" },
                    { name = "nvim_lsp_signature_help" },
                }),
            })

            -- Use buffer source for `/` and `?` (if `native_menu` is enabled this won't work anymore).
            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })

            -- Use cmdline & path source for ':' (if `native_menu` is enabled this won't work anymore).
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    { name = 'cmdline' }
                }),
                matching = { disallow_symbol_nonprefix_matching = false }
            })
        end,
    },
}
