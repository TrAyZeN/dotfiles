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
            },
            notify_on_error = true,
            format_on_save = {
                lsp_fallback = true,
                timeout_ms = 200,
            },
            format_after_save = {
                lsp_fallback = true,
            },
        },
        config = function(plugin, opts)
            require("conform").setup(opts)

            -- Format on save
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*",
                callback = function(args)
                    require("conform").format({ async = true, bufnr = args.buf })
                end,
            })
        end,
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
