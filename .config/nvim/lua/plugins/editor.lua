return {
    -- Navigate files
    {
        "justinmk/vim-dirvish",
        init = function()
            vim.g.dirvish_mode = ":sort ,^.*[\\/],"
        end,
    },
    -- git gud
    { "tpope/vim-fugitive" },
    -- Maybe not needed we could use :Commits from fzf
    -- Plug('rbong/vim-flog', { branch = 'master' })
    -- Format code
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                python = { "isort", "black" },
                rust = { "rustfmt", lsp_format = "fallback" },
            },
            notify_on_error = true,
            default_format_opts = {
                lsp_format = "fallback",
                timeout_ms = 500,
            },
        },
    },
    -- Display keys
    {
        "folke/which-key.nvim",
        opts = {
            triggers_nowait = {
                -- marks
                "`",
                "'",
                "g`",
                "g'",
                -- registers
                '"',
                "<c-r>",
                -- spelling
                "z=",
            }
        },
        config = function(plugin, opts)
            require("which-key").setup(opts)

            vim.o.timeout = true
            vim.o.timeoutlen = 500
        end,
    },
    -- Highlight todo comments
    {
        "folke/todo-comments.nvim",
        opts = {
            signs = false,
        },
    },
}
