-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        { import = "plugins" },

        -- Surround things
        { "tpope/vim-surround" },

        -- Run commands asynchronously
        { "tpope/vim-dispatch" },

        -- Clock is ticking
        -- { "wakatime/vim-wakatime" },

        -- UNIX helpers
        -- rename file with :Rename
        { "tpope/vim-eunuch" },

        -- { "tpope/vim-projectionist" },

        -- More text objects
        -- { "wellle/targets.vim" },

        -- Languages
        { "cespare/vim-toml" },
        { "tikhomirov/vim-glsl" },
        { "elixir-editors/vim-elixir" },

        -- Lua functions
        { "nvim-lua/plenary.nvim", lazy = true },
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "gruvbox" } },
    -- automatically check for plugin updates
    checker = { enabled = true },
})
