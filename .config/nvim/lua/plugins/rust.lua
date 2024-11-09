return {
    {
        "rust-lang/rust.vim",
        config = function()
            vim.g.rust_use_custom_ctags_defs = 1
            vim.g.rustfmt_autosave = 1
        end,
    },

    -- Tools for better development in rust
    {
        "simrat39/rust-tools.nvim",
        -- https://sharksforarms.dev/posts/neovim-rust/
        -- Configure LSP
        -- https://github.com/neovim/nvim-lspconfig#rust_analyzer
        opts = {
            tools = {
                autoSetHints = true,
                --hover_with_actions = true,
                runnables = {
                    use_telescope = true
                },
                inlay_hints = {
                    show_parameter_hints = false,
                    parameter_hints_prefix = "",
                    other_hints_prefix = "",
                },
            },

            -- all the opts to send to nvim-lspconfig
            -- these override the defaults set by rust-tools.nvim
            -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
            server = {
                -- on_attach is a callback called when the language server attachs to the buffer
                -- on_attach = on_attach,
                settings = {
                    -- to enable rust-analyzer settings visit:
                    -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
                    ["rust-analyzer"] = {
                        -- enable clippy on save
                        checkOnSave = {
                            command = "clippy"
                        },
                    }
                }
            },
        }
    },
}
