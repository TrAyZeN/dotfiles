-- General settings

vim.cmd([[ colorscheme gruvbox ]])
vim.opt.bg = 'dark'

vim.cmd([[ filetype plugin indent on ]])

--------------------------
-- Indentation and tabs
--------------------------
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Doesn't seem to be working with globbing
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'*.json', '*.md', '*.toml', '*.yaml', '*.yml', '*.html'},
    command = 'setlocal ts=2 sw=2'
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'tex',
    command = 'setlocal ts=2 sw=2'
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'verilog',
    command = 'setlocal ts=2 sw=2'
})

-- max line length
vim.opt.textwidth = 80
vim.opt.colorcolumn = '80'

vim.cmd [[ highlight ColorColumn ctermbg=DarkGray guibg=DarkGray ]]

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'*.js'},
    command = 'setlocal textwidth=100 colorcolumn=100'
})

-- Indications
vim.opt.number = true
vim.opt.relativenumber = true
vim.cmd([[
    syntax on
]])

vim.showmatch = true -- Show matching parenthesis
vim.opt.list = true -- Show listchars
vim.opt.listchars = { tab = '..', trail = '~', eol = '$' }
vim.opt.hlsearch = true -- Highlight search

-- Needed by some plugins to display colors
vim.opt.termguicolors = true

-- TODO: Insert autocmd FileType * setlocal formatoptions-=ro

-- Command completion
vim.opt.wildmenu = true
-- vim.opt.wildmode = 'longest:full', 'full'
vim.cmd [[ set wildmode=longest:full,full ]]

-- Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force user to select one from the menu
vim.opt.completeopt = 'menuone', 'noinsert', 'noselect'

-- Avoid showing extra messages when using completion
vim.opt.shortmess:append('c')

vim.opt.encoding = 'utf8'

-- Keep 5 lines below and above the cursor
vim.opt.scrolloff = 5

-- Don't redraw when executing macros
vim.opt.lazyredraw = true

-- Goodbye trash file
vim.opt.swapfile = false

-- Auto load file when it has been changed outside of vim
vim.opt.autoread = true

-- Set updatetime for CursorHold
-- 300ms of no cursor movement to trigger CursorHold
vim.opt.updatetime = 300

vim.env.MANSECT = '2:3:1:8:5:4:9:6:7'

-- Use shift+k to open man page under the cursor
vim.opt.keywordprg = ':Man'
