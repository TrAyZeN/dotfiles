-- Swag stuff
return {
    -- colorscheme
    {
        "morhetz/gruvbox",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme gruvbox]])
            vim.opt.bg = "dark"
        end,
    },
    -- { "ellisonleao/gruvbox.nvim" },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = {
                theme = "gruvbox",
                -- section_separators = "",
                -- component_separators = "|",
            }
        },
    },
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {},
    },
}
