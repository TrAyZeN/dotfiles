-- Plugins loading and configuration

local Plug = vim.fn['plug#']

vim.call('plug#begin')

-- Improve startup time ?
-- Plug 'lewis6991/impatient.nvim'

-- Movement speed
-- Plug 'ludovicchabant/vim-gutentags'
Plug 'justinmk/vim-dirvish'

-- Surround things
Plug 'tpope/vim-surround'

-- Commenting made easy
Plug 'preservim/nerdcommenter'

-- Run commands asynchronously
Plug 'tpope/vim-dispatch'

-- Swag stuff
Plug 'morhetz/gruvbox'
-- Plug 'ellisonleao/gruvbox.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim'

-- git gud
Plug 'tpope/vim-fugitive'
-- Maybe not needed we could use :Commits from fzf
-- Plug('rbong/vim-flog', { branch = 'master' })

-- Clock is ticking
Plug 'wakatime/vim-wakatime'

-- Manage personal wiki
Plug 'vimwiki/vimwiki'

-- UNIX helpers
-- rename file with :Rename
Plug 'tpope/vim-eunuch'

-- Fasto file fuzzy finding
Plug('junegunn/fzf', {
    ['do'] = function()
        vim.fn['fzf#install']()
    end
})
Plug 'junegunn/fzf.vim'

-- Plug 'tpope/vim-projectionist'

-- Stop typing same things all day
-- Plug 'SirVer/ultisnips'

-- More text objects
-- Plug 'wellle/targets.vim'

-- Quickstart configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

-- Support snippets from LSP
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
-- Plug 'rafamadriz/friendly-snippets'

Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

-- Languages
Plug 'cespare/vim-toml'
Plug 'tikhomirov/vim-glsl'
Plug 'rust-lang/rust.vim'
Plug 'elixir-editors/vim-elixir'

-- Tools for better development in rust
Plug 'simrat39/rust-tools.nvim'

-- Display keys
Plug 'folke/which-key.nvim'

vim.call('plug#end')

--------------------------
-- Plugins configuration
--------------------------
require('lualine').setup({
    options = {
        theme = 'gruvbox',
        -- section_separators = '',
        -- component_separators = '|',
    }
})

vim.g.loaded_clipboard_provider = 1

-- Create default mappings
vim.g.NERDCreateDefaultMappings = 1
-- Add spaces after comment delimiters
vim.g.NERDSpaceDelims = 1
-- Use compacct syntax for prettified multi-line comments
vim.g.NERDCompactSexyComs = 1
-- Align line-wise comment delimiters flush left instead of following code
-- identation
vim.g.NERDDefaultAlgin = 'left'
-- Enable NERDCommenterToggle to check all selected lines is commented or not
vim.g.NERDToggleCheckAllLines = 1

vim.g.rust_use_custom_ctags_defs = 1
vim.g.rustfmt_autosave = 1

vim.g.any_jump_search_prefered_engine = 'rg'

vim.g.vimwiki_list = {{ path = '~/vimwiki/', syntax = 'markdown', ext = '.md' }}
vim.g.vimwiki_global_ext = 0

vim.g.dirvish_mode = ':sort ,^.*[\\/],'

-- vim.cmd [[
    -- function! s:build_quickfix_list(lines)
      -- call setqflist(map(copy(a:lines), '{ "filename": v:val, "lnum": 1 }'))
      -- " copen
      -- " cc
    -- endfunction
    -- let g:fzf_action = { 'ctrl-a': function('s:build_quickfix_list'), 'ctrl-s': 'split', 'ctrl-v': 'vsplit' }

    -- function! RipgrepFzf(query, fullscreen)
      -- let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
      -- let initial_command = printf(command_fmt, shellescape(a:query))
      -- let reload_command = printf(command_fmt, '{q}')
      -- let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
      -- call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
    -- endfunction

    -- command! -nargs=* -bang Salut call RipgrepFzf(<q-args>, <bang>0)
-- ]]

vim.g.fzf_preview_window = {}
vim.g.fzf_layout = { down = '30%' }
-- vim.g.fzf_action = {
    -- ['ctrl-q'] = function('s:build_quickfix_list'),
    -- ['ctrl-q'] = function(lines)
        -- vim.cmd [[
            -- call setqflist(map(copy(a:lines), '{ "filename": v:val, "lnum": 1 }'))
            -- copen
            -- cc
        -- ]]
    -- end,
    -- ['ctrl-q'] = vim.fn['s:build_quickfix_list'],
    -- ['ctrl-s'] = 'split',
    -- ['ctrl-v'] = 'vsplit'
-- }

vim.api.nvim_create_user_command(
    'RipGrep',
    'call fzf#run(fzf#wrap({ \'source\': \'rg --files --hidden --glob=!.git/\' }))',
    { nargs = '*', bang = true }
)
vim.api.nvim_create_user_command('Todo', ':vimgrep /TODO/gj src/**/*.[ch] | copen', { nargs = 0 })

-- https://sharksforarms.dev/posts/neovim-rust/
-- Configure LSP
-- https://github.com/neovim/nvim-lspconfig#rust_analyzer

-- nvim_lsp object
local nvim_lsp = require'lspconfig'

local opts = {
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

require('lspconfig').clangd.setup({
    filetypes = { "c", "h", "cpp", "hpp", "cc", "hh", "hxx" }
})

require('lspconfig').pyright.setup({
})

require('lspconfig').verible.setup({
})

require('rust-tools').setup(opts)

-- Setup Completion
-- See https://github.com/hrsh7th/nvim-cmp#basic-configuration
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<Tab>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
})

require('nvim-treesitter.configs').setup({
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
})

require('nvim-treesitter.configs').setup({
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
})

vim.o.timeout = true
vim.o.timeoutlen = 500
require('which-key').setup({
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
})

require("bufferline").setup{}
