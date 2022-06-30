call plug#begin()

" Movement speed
" Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-vinegar'

" Surround things
Plug 'tpope/vim-surround'

" Commenting made easy
Plug 'preservim/nerdcommenter'

" Run commands asynchronously
Plug 'tpope/vim-dispatch'

" Swag stuff
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" git gud
Plug 'tpope/vim-fugitive'
Plug 'rbong/vim-flog', { 'branch': 'master' }

" Clock is ticking
Plug 'wakatime/vim-wakatime'

" Manage personal wiki
Plug 'vimwiki/vimwiki'

" UNIX helpers
" rename file with :Rename
Plug 'tpope/vim-eunuch'

" Show registers content
Plug 'junegunn/vim-peekaboo'

" Fasto file fuzzy finding
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Plug 'tpope/vim-projectionist'

" Stop typing same things all day
" Plug 'SirVer/ultisnips'

" More text objects
" Plug 'wellle/targets.vim'

" Languages
Plug 'cespare/vim-toml'
Plug 'tikhomirov/vim-glsl'
Plug 'rust-lang/rust.vim'
Plug 'elixir-editors/vim-elixir'

" Bearded vim user fear
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'pechorin/any-jump.vim'

" Quickstart configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" Support snippets from LSP
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
" Plug 'rafamadriz/friendly-snippets'

" Tools for better development in rust
Plug 'simrat39/rust-tools.nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

call plug#end()

colorscheme gruvbox
set bg=dark

filetype plugin indent on

"""""""""""""""""""""""
" Indentation and tabs
"""""""""""""""""""""""
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set autoindent
set smartindent

autocmd Filetype json,md,toml,yaml,html setlocal ts=2 sw=2

" max line length
set textwidth=80
set colorcolumn=80
highlight ColorColumn ctermbg=DarkGray guibg=green

autocmd FileType javascript setlocal textwidth=100 colorcolumn=100

" Indications
set number
set relativenumber
syntax on
set showmatch " show matching parenthesis
set list
set listchars=tab:..,trail:~,eol:$
set hlsearch " Highlight search

" disable text format when
" - hitting <Enter> in Insert mode
" - hitting 'o' or 'O' in Normal mode
autocmd FileType * setlocal formatoptions-=ro

" Command completion
set wildmenu
set wildmode=longest:full,full

" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

set encoding=utf8

" Keep 5 lines below and above the cursor
set scrolloff=5

" Don't redraw when executing macros
set lazyredraw

" Goodbye trash file
set noswapfile

" Auto load file when it has been changed outside of vim
set autoread

set encoding=utf8

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300

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

" augroup AutoSaveFolds
  " autocmd!
  " autocmd BufWinLeave * mkview
  " autocmd BufWinEnter * silent! loadview
" augroup END

let $MANSECT="2:3:1:8:5:4:9:6:7"

" Use shift+k to open man page under the cursor
set keywordprg=:Man

let mapleader = "\<Space>"

"""""""""""""""""""""""
" Remaps and commands
"""""""""""""""""""""""

" Avoid mistypes
command W w
command Q q
command WQ wq

" Close buffer but don't close split
command Bd bp|bd #

" ctrl+s to save
noremap <C-S> :w<CR>
inoremap <C-S> <Esc>:w<CR>

nnoremap Y y$

" Go to file under cursor and create it if not existing
" nnoremap gf :e <cfile><CR>

" ctrl+/ toggle comment
map <C-_> <Leader>c<space>

" Bash like keys for the command line
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-K> <C-U>
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

" Move selected lines using alt+[jk]
vnoremap <M-j> :m '>+1<CR>gv=gv
vnoremap <M-k> :m '<-2<CR>gv=gv

" Navigate buffers with ctrl+[np]
nnoremap <silent> <C-N> :bnext<CR>
nnoremap <silent> <C-P> :bprevious<CR>

" Quickfix list mappings
nnoremap <C-J> :cn<CR>
nnoremap <C-K> :cp<CR>

" make mappings
nnoremap <Leader>ma :Make<CR>
nnoremap <Leader>mr :Make run<CR>
nnoremap <Leader>mt :Make test<CR>

" fugitive mappings
nnoremap <Leader>gg :Git<CR>
nnoremap <Leader>gb :Git blame<CR>
nnoremap <Leader>gd :Gvdiffsplit<CR>
nnoremap <Leader>ga :Git add %<CR>
nnoremap <Leader>gc :Git commit<CR>
nnoremap <Leader>gl :Flog<CR>

" File mappings
nnoremap <Leader>fR :Rename<space>
nnoremap <Leader>fm :Chmod<space>
nnoremap <Leader>fa :A<CR>
nnoremap <Leader>ff :RipGrep<CR>
nnoremap <Leader>fr :History<CR>

" Buffer mappings
nnoremap <Leader>bo :%bd <bar> e#<CR>

" nnoremap <Leader>s :exec "vimgrep /" . expand("<cword>") . "/g src/**/*.c"<CR>:copen<CR>

" Code navigation shortcuts
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
" rust-analyzer does not yet support go to declaration
" nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gn    <cmd>lua vim.lsp.buf.declaration()<CR>

" Trigger code action
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Anyjump mappings
" Normal mode: Jump to definition under cursor
nnoremap <leader>j :AnyJump<CR>
" Visual mode: jump to selected text in visual mode
xnoremap <leader>j :AnyJumpVisual<CR>
" Normal mode: open previous opened file (after jump)
nnoremap <leader>ab :AnyJumpBack<CR>
" Normal mode: open last closed search window again
nnoremap <leader>al :AnyJumpLastResults<CR>

" Snippets mappings
" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" Fix key binding conflict between vim-vinegar and vimwiki
nmap <Nop> <Plug>VimwikiRemoveHeaderLevel

" Terminal mappings
nnoremap <leader>tt :terminal<CR>i
nnoremap <leader>ts :rightbelow new<CR>:terminal<CR>i
tnoremap <Esc> <C-\><C-n>
tnoremap <C-v><Esc> <Esc>

"""""""""""""""""""""""
" Plugins configuration
"""""""""""""""""""""""
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

let g:loaded_clipboard_provider = 1

" Create default mappings
let g:NERDCreateDefaultMappings = 1
" Add spaces after comment delimiters
let g:NERDSpaceDelims = 1
" Use compacct syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code
" identation
let g:NERDDefaultAlgin = 'left'
" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

let g:rust_use_custom_ctags_defs = 1
let g:rustfmt_autosave = 1

let g:any_jump_search_prefered_engine = 'rg'

let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown',
                        \ 'ext': '.md' }]
let g:vimwiki_global_ext = 0

let g:fzf_preview_window = []
let g:fzf_layout = { 'down': '30%' }

command! -bang -nargs=* RipGrep
            \ call fzf#run(fzf#wrap({ 'source': 'rg --files --hidden --glob=!.git/' }))

command -nargs=0 Todo :vimgrep /TODO/gj src/**/*.[ch] | copen

" https://sharksforarms.dev/posts/neovim-rust/
" Configure LSP
" https://github.com/neovim/nvim-lspconfig#rust_analyzer
lua <<EOF

-- nvim_lsp object
local nvim_lsp = require'lspconfig'

local opts = {
    tools = {
        autoSetHints = true,
        hover_with_actions = true,
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

require'lspconfig'.clangd.setup {
    filetypes = { "c", "h", "cpp", "hpp", "cc", "hh", "hxx" }
}

require'lspconfig'.pyright.setup {
}

require('rust-tools').setup(opts)
EOF

" Setup Completion
" See https://github.com/hrsh7th/nvim-cmp#basic-configuration
lua <<EOF
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
EOF

lua <<EOF
require'nvim-treesitter.configs'.setup {
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
}
EOF

lua <<EOF
require'nvim-treesitter.configs'.setup {
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
      },
    },
  },
}
EOF
