return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            -- One of "all", "maintained" (parsers with maintainers), or a list of languages
            ensure_installed = "all",

            -- Install languages synchronously (only applied to `ensure_installed`)
            sync_install = false,

            -- List of parsers to ignore installing
            ignore_install = { "" },

            highlight = {
                -- `false` will disable the whole extension
                enable = true,

                -- list of language that will be disabled
                disable = { "" },

                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = false,
            },
            ident = {
                enable = true,
                disable = { "" },
            },

            -- Configure nvim-treesitter-textobjects
            textobjects = {
                select = {
                    enable = true,

                    -- Automatically jump forward to textobj, similar to targets.vim
                    lookahead = true,

                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                        ["ab"] = "@block.outer",
                        ["ib"] = "@block.inner",
                    },
                },
            },
        },
    },
    { "nvim-treesitter/nvim-treesitter-textobjects" },
}
