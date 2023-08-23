vim.g.mapleader = ' '

------------------------
-- Remaps and commands
------------------------

-- Avoid mistypes
vim.api.nvim_create_user_command('W', 'w', {})
vim.api.nvim_create_user_command('Q', 'q', {})
vim.api.nvim_create_user_command('WQ', 'wq', {})

-- Close buffer but don't close split
vim.api.nvim_create_user_command('Bd', 'bp|bd #', {})

-- ctrl+s to save
vim.keymap.set('', '<C-S>', ':w<CR>', { noremap = true })
vim.keymap.set('i', '<C-S>', '<Esc>:w<CR>', { noremap = true })

-- Copy line from cursor to the end
-- same behavior as D
vim.keymap.set('n', 'Y', 'y$', { noremap = true })

-- Go to file under cursor and create it if not existing
-- nnoremap gf :e <cfile><CR>

-- ctrl+/ toggle comment
vim.cmd [[
    map <C-_> <Leader>c<space>
]]
-- vim.keymap.set('', '<C-_>', '<Leader>c<space>')

-- Bash like keys for the command line
vim.keymap.set('c', '<C-A>', '<Home>', { noremap = true })
vim.keymap.set('c', '<C-E>', '<End>', { noremap = true })
vim.keymap.set('c', '<C-K>', '<C-U>', { noremap = true })
vim.keymap.set('c', '<C-P>', '<Up>', { noremap = true })
vim.keymap.set('c', '<C-N>', '<Down>', { noremap = true })

-- Move selected lines using alt+[jk]
vim.keymap.set('v', '<M-j>', ':m \'>+1<CR>gv=gv', { noremap = true })
vim.keymap.set('v', '<M-k>', ':m \'<-2<CR>gv=gv', { noremap = true })

-- Navigate buffers with ctrl+[np]
vim.keymap.set('n', '<C-N>', ':bnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-P>', ':bprevious<CR>', { noremap = true, silent = true })

-- Quickfix list mappings
vim.keymap.set('n', '<C-J>', ':cn<CR>', { noremap = true })
vim.keymap.set('n', '<C-K>', ':cp<CR>', { noremap = true })

-- make mappings
vim.keymap.set('n', '<Leader>ma', ':Make<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>mr', ':Make run<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>mt', ':Make test<CR>', { noremap = true })

-- fugitive mappings
vim.keymap.set('n', '<Leader>gg', ':Git<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>gb', ':Git blame<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>gd', ':Gvdiffsplit<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>ga', ':Git add %<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>gc', ':Git commit<CR>', { noremap = true })
-- vim.keymap.set('n', '<Leader>gl', ':Flog<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>gl', ':Commits<CR>', { noremap = true })

-- File mappings
vim.keymap.set('n', '<Leader>fR', ':Rename<space>', { noremap = true })
vim.keymap.set('n', '<Leader>fm', ':Chmod<space>', { noremap = true })
vim.keymap.set('n', '<Leader>fd', ':Mkdir<space>', { noremap = true })
vim.keymap.set('n', '<Leader>fa', ':A<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>ff', ':RipGrep<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>fh', ':History<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>ft', ':Rg ', { noremap = true })

-- Buffer mappings
vim.keymap.set('n', '<Leader>bo', ':if bufnr(\'%\') > 1 | 1,-1bd | endif | if bufnr(\'%\') < bufnr(\'$\') | +1,$bd | endif | redraw! <CR>', { noremap = true, desc = "Delete all other buffers (keep only the current one)" })

-- " nnoremap <Leader>s :exec "vimgrep /" . expand("<cword>") . "/g src/**/*.c"<CR>:copen<CR>

-- Code navigation shortcuts
vim.keymap.set('n', '<c-]>', vim.lsp.buf.definition, { noremap = true, silent = true })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { noremap = true, silent = true })
vim.keymap.set('n', 'gD', vim.lsp.buf.implementation, { noremap = true, silent = true })
vim.keymap.set('n', '<c-k>', vim.lsp.buf.signature_help, { noremap = true, silent = true })
vim.keymap.set('n', '1gD', vim.lsp.buf.type_definition, { noremap = true, silent = true })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { noremap = true, silent = true })
vim.keymap.set('n', 'g0', vim.lsp.buf.document_symbol, { noremap = true, silent = true })
vim.keymap.set('n', 'gW', vim.lsp.buf.workspace_symbol, { noremap = true, silent = true })

-- rust-analyzer does not yet support go to declaration
-- " nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { noremap = true, silent = true })
vim.keymap.set('n', 'gn', vim.lsp.buf.declaration, { noremap = true, silent = true })

-- Trigger code action
vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, { noremap = true, silent = true })

-- Goto previous/next diagnostic warning/error
-- vim.keymap.set('n', 'g[', vim.lsp.diagnostic.goto_prev, { noremap = true, silent = true })
-- vim.keymap.set('n', 'g]', vim.lsp.diagnostic.goto_next, { noremap = true, silent = true })

-- Use <Tab> and <S-Tab> to navigate through popup menu
-- vim.keymap.set('i', '<Tab>', function() vim.cmd [[ pumvisible() ? "\<C-n>" : "\<Tab>" ]] end, { noremap = true, expr = true })

-- Use <Tab> and <S-Tab> to navigate through popup menu
vim.cmd [[ inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>" ]]
vim.cmd [[ inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>" ]]

-- Anyjump mappings
-- Normal mode: Jump to definition under cursor
vim.keymap.set('n', '<Leader>j', ':AnyJump<CR>', { noremap = true })
-- Visual mode: jump to selected text in visual mode
vim.keymap.set('x', '<Leader>j', ':AnyJumpVisual<CR>', { noremap = true })
-- Normal mode: open previous opened file (after jump)
vim.keymap.set('n', '<Leader>ab', ':AnyJumpBack<CR>', { noremap = true })
-- Normal mode: open last closed search window again
vim.keymap.set('n', '<Leader>al', ':AnyJumpLastResults<CR>', { noremap = true })

-- Snippets mappings
-- Expand or jump
vim.cmd [[ imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>' ]]
vim.cmd [[ smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>' ]]
-- Jump forward or backward
vim.cmd [[ imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>' ]]
vim.cmd [[ smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>' ]]
vim.cmd [[ imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>' ]]
vim.cmd [[ smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>' ]]

-- Fix key binding conflict between vim-vinegar and vimwiki
vim.keymap.set('n', '<Nop>', '<Plug>VimwikiRemoveHeaderLevel', { noremap = false })

-- Terminal mappings
vim.keymap.set('n', '<Leader>tt', ':terminal<CR>i', { noremap = true })
vim.keymap.set('n', '<Leader>ts', ':rightbelow new<CR>:terminal<CR>i', { noremap = true })
vim.cmd [[ tnoremap <Esc> <C-\><C-n> ]]
vim.keymap.set('t', '<C-v><Esc>', '<Esc>', { noremap = true })
