lua<<EOF

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
    -- Improve startup time ?
    -- { "lewis6991/impatient.nvim" },

    -- Movement speed
    -- { "ludovicchabant/vim-gutentags" },
    { "justinmk/vim-dirvish" },

    -- Surround things
    { "tpope/vim-surround" },

    -- Run commands asynchronously
    { "tpope/vim-dispatch" },

    -- Swag stuff
    { "morhetz/gruvbox" },
    -- { "ellisonleao/gruvbox.nvim" },
    { "nvim-lualine/lualine.nvim" },
    { "nvim-tree/nvim-web-devicons" },
    { "akinsho/bufferline.nvim" },

    -- git gud
    { "tpope/vim-fugitive" },
    -- Maybe not needed we could use :Commits from fzf
    -- Plug('rbong/vim-flog', { branch = 'master' })

    -- Clock is ticking
    -- { "wakatime/vim-wakatime" },

    -- Manage personal wiki
    { "vimwiki/vimwiki" },

    -- UNIX helpers
    -- rename file with :Rename
    { "tpope/vim-eunuch" },

    -- Fasto file fuzzy finding
    {
        "junegunn/fzf",
        build = function()
            vim.fn["fzf#install"]()
        end,
    },
    { "junegunn/fzf.vim" },

    -- { "tpope/vim-projectionist" },

    -- Stop typing same things all day
    -- { "SirVer/ultisnips" },

    -- More text objects
    -- { "wellle/targets.vim" },

    -- Quickstart configurations for the Nvim LSP client
    { "neovim/nvim-lspconfig" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-cmdline" },
    { "hrsh7th/nvim-cmp" },

    -- Support snippets from LSP
    { "hrsh7th/cmp-vsnip" },
    { "hrsh7th/vim-vsnip" },
    -- { "rafamadriz/friendly-snippets" },

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },
    { "nvim-treesitter/nvim-treesitter-textobjects" },

    -- Format code
    { "stevearc/conform.nvim" },

    -- Languages
    { "cespare/vim-toml" },
    { "tikhomirov/vim-glsl" },
    { "rust-lang/rust.vim" },
    { "elixir-editors/vim-elixir" },

    -- Tools for better development in rust
    { "simrat39/rust-tools.nvim" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "gruvbox" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

require("user.plugins")
require("user.settings")
require("user.keymap")

EOF

" disable text format when
" - hitting <Enter> in Insert mode
" - hitting 'o' or 'O' in Normal mode
autocmd FileType * setlocal formatoptions-=ro

" Show diagnostic popup on cursor hover
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })

" have a fixed column for the diagnostics to appear in
" this removes the jitter when warnings/errors flow in
set signcolumn=yes

" Use shift+k to open man page under the cursor
" set keywordprg=:Man

" Enable type inlay hints
" autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
" \ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }

autocmd FileType c,cc,cpp setlocal path+=/usr/include include &

" Auto format with clang format
" From https://vi.stackexchange.com/questions/21102/how-to-clang-format-the-current-buffer-on-save
function FormatBuffer()
  if &modified && !empty(findfile('.clang-format', expand('%:p:h') . ';'))
    let cursor_pos = getpos('.')
    :%!clang-format
    call setpos('.', cursor_pos)
  endif
endfunction

autocmd BufWritePre *.h,*.hh,*.hpp,*.hxx,*.c,*.cc,*.cpp,*.vert,*.frag :call FormatBuffer()

" Format verilog files
" From https://danielmangum.com/posts/setup-verible-verilog-neovim/
autocmd BufWritePost *.v lua vim.lsp.buf.format({ async = false })

" augroup AutoSaveFolds
  " autocmd!
  " autocmd BufWinLeave * mkview
  " autocmd BufWinEnter * silent! loadview
" augroup END

set grepprg=rg\ --vimgrep
set grepformat=%f:%l:%c:%m
