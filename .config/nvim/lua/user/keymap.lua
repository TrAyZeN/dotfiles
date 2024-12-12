local wk = require("which-key")

vim.g.mapleader = " "

------------------------
-- Remaps and commands
------------------------

-- Avoid mistypes
vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("Q", "q", {})
vim.api.nvim_create_user_command("WQ", "wq", {})

-- Close buffer but don't close split
vim.api.nvim_create_user_command("Bd", "bp|bd<bang> #", { bang = true })

-- ctrl+s to save
vim.keymap.set({ "n", "v", "i" }, "<C-S>", "<Cmd>w<CR><Esc>", { noremap = true, desc = "Save file" })

-- Copy line from cursor to the end
-- same behavior as D
vim.keymap.set("n", "Y", "y$", { noremap = true })

-- Go to file under cursor and create it if not existing
-- nnoremap gf :e <cfile><CR>

-- ctrl+/ toggle comment
vim.keymap.set({ "n", "v", "o" }, "<C-_>", ":norm gc$<CR>", { noremap = true, desc = "Toggle line comment" })

-- Keep cursor centered while moving
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Bash like keys for the command line
vim.keymap.set("c", "<C-a>", "<Home>", { noremap = true })
vim.keymap.set("c", "<C-e>", "<End>", { noremap = true })
vim.keymap.set("c", "<C-k>", "<C-u>", { noremap = true })
vim.keymap.set("c", "<C-p>", "<Up>", { noremap = true })
vim.keymap.set("c", "<C-n>", "<Down>", { noremap = true })

-- Move selected lines up/down with alt+[jk]
vim.keymap.set("v", "<M-j>", ":m \'>+1<CR>gv=gv", { noremap = true })
vim.keymap.set("v", "<M-k>", ":m \'<-2<CR>gv=gv", { noremap = true })

-- Quickfix list mappings
-- vim.keymap.set("n", "<C-j>", ":cn<CR>", { noremap = true })
-- vim.keymap.set("n", "<C-k>", ":cp<CR>", { noremap = true })

wk.add({
    { "<Leader>m", group = "make" },
    { "<Leader>ma", ":Make<CR>", mode = "n", noremap = true, desc = "make" },
    { "<Leader>mr", ":Make run<CR>", mode = "n", noremap = true, desc = "make run" },
    { "<Leader>mt", ":Make test<CR>", mode = "n", noremap = true, desc = "make test" },
})

wk.add({
    { "<Leader>g", group = "git" },
    { "<Leader>gg", ":Git<CR>", mode = "n", noremap = true, desc = "git status" },
    { "<Leader>gb", ":Git blame<CR>", mode = "n", noremap = true, desc = "git blame" },
    { "<Leader>gd", ":Gvdiffsplit<CR>", mode = "n", noremap = true, desc = "git diff" },
    { "<Leader>ga", ":Git add %<CR>", mode = "n", noremap = true, desc = "git add current file" },
    { "<Leader>gc", ":Git commit<CR>", mode = "n", noremap = true, desc = "git commit" },
    { "<Leader>gl", ":Commits<CR>", mode = "n", noremap = true, desc = "git log" },
})
-- vim.keymap.set("n", "<Leader>gl", ":Flog<CR>", { noremap = true })

wk.add({
    { "<Leader>f", group = "file/find" },
    { "<Leader>ff", ":RipGrep<CR>", mode = "n", noremap = true, desc = "Find file" },
    { "<Leader>fr", ":Rg ", mode = "n", noremap = true, desc = "ripgrep" },
    { "<Leader>fR", ":Rename<space>", mode = "n", noremap = true, desc = "Rename file" },
    { "<Leader>fc", ":Chmod<space>", mode = "n",  noremap = true, desc = "chmod file" },
    { "<Leader>fd", ":Mkdir<space>", mode = "n", noremap = true, desc = "Create directory" },
    { "<Leader>fh", ":History<CR>", mode = "n", noremap = true, desc = "History of open buffers" },
    { "<Leader>fm", ":Apropos<CR>", mode = "n", noremap = true, desc = "Find in man pages" },
})

wk.add({
    { "<Leader>b", group = "buffer" },
    { "<Leader>bp", ":bp<CR>", mode = "n", noremap = true, desc = "Previous buffer" },
    { "<Leader>bn", ":bn<CR>", mode = "n", noremap = true, desc = "Next buffer" },
    { "<Leader>bo", ":if bufnr(\'%\') > 1 | 1,-1bd | endif | if bufnr(\'%\') < bufnr(\'$\') | +1,$bd | endif | redraw! <CR>", mode = "n", noremap = true, desc = "Delete other buffers" },
    { "<Leader>bd", ":Bd<CR>", mode = "n", noremap = false, desc = "Delete buffer" },
})

-- Shortcuts for buffer navigation
-- Navigate buffers with ctrl+[np]
vim.keymap.set("n", "<C-n>", ":bnext<CR>", { noremap = true, silent = true, desc = "Next buffer" })
vim.keymap.set("n", "<C-p>", ":bprevious<CR>", { noremap = true, silent = true, desc = "Previous buffer" })

-- " nnoremap <Leader>s :exec "vimgrep /" . expand("<cword>") . "/g src/**/*.c"<CR>:copen<CR>

-- Code navigation shortcuts
wk.add({
    { "<Leader>l", group = "LSP" },
    { "<Leader>ld", vim.lsp.buf.definition, mode = "n", noremap = true, silent = true, desc = "Go to definition" },
    { "<Leader>lD", vim.lsp.buf.declaration, mode = "n", noremap = true, silent = true, desc = "Go to declaration" },
    { "<Leader>li", vim.lsp.buf.implementation, mode = "n", noremap = true, silent = true, desc = "Go to implementation" },
    { "<Leader>ly", vim.lsp.buf.type_definition, mode = "n", noremap = true, silent = true, desc = "Go to type definition" },
    { "<Leader>lr", vim.lsp.buf.references, mode = "n", noremap = true, silent = true, desc = "List references" },
    { "<Leader>la", vim.lsp.buf.code_action, mode = "n", noremap = true, silent = true, desc = "Run code action" },
})
-- Shortcuts for LSP
-- vim.keymap.set("n", "<C-]>", vim.lsp.buf.definition, { noremap = true, silent = true })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true, silent = true })
-- rust-analyzer does not yet support go to declaration
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true, desc = "go to definition" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { noremap = true, silent = true, desc = "go to declaration" })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { noremap = true, silent = true, desc = "go to implementation" })
-- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { noremap = true, silent = true })
vim.keymap.set("n", "1gD", vim.lsp.buf.type_definition, { noremap = true, silent = true })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { noremap = true, silent = true, desc = "list references" })
vim.keymap.set("n", "g0", vim.lsp.buf.document_symbol, { noremap = true, silent = true })
vim.keymap.set("n", "gW", vim.lsp.buf.workspace_symbol, { noremap = true, silent = true })
vim.keymap.set("n", "ga", vim.lsp.buf.code_action, { noremap = true, silent = true, desc = "select code action" })

-- Goto previous/next diagnostic warning/error
-- vim.keymap.set("n", "g[", vim.lsp.diagnostic.goto_prev, { noremap = true, silent = true })
-- vim.keymap.set("n", "g]", vim.lsp.diagnostic.goto_next, { noremap = true, silent = true })

-- Use <Tab> and <S-Tab> to navigate through popup menu
-- vim.keymap.set("i", "<Tab>", function() vim.cmd [[ pumvisible() ? "\<C-n>" : "\<Tab>" ]] end, { noremap = true, expr = true })

-- Use <Tab> and <S-Tab> to navigate through popup menu
vim.cmd [[ inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>" ]]
vim.cmd [[ inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>" ]]

-- -- Anyjump mappings
-- -- Normal mode: Jump to definition under cursor
-- vim.keymap.set("n", "<Leader>j", ":AnyJump<CR>", { noremap = true })
-- -- Visual mode: jump to selected text in visual mode
-- vim.keymap.set("x", "<Leader>j", ":AnyJumpVisual<CR>", { noremap = true })
-- -- Normal mode: open previous opened file (after jump)
-- vim.keymap.set("n", "<Leader>ab", ":AnyJumpBack<CR>", { noremap = true })
-- -- Normal mode: open last closed search window again
-- vim.keymap.set("n", "<Leader>al", ":AnyJumpLastResults<CR>", { noremap = true })
-- -- vim.keymap.set("n", "<Leader>fa", ":A<CR>", { noremap = true })

-- Snippets mappings
-- Expand or jump
-- vim.cmd [[ imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>' ]]
-- vim.cmd [[ smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>' ]]
-- Jump forward or backward
vim.cmd [[ imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>' ]]
vim.cmd [[ smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>' ]]
vim.cmd [[ imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>' ]]
vim.cmd [[ smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>' ]]

-- Fix key binding conflict between vim-vinegar and vimwiki
vim.keymap.set("n", "<Nop>", "<Plug>VimwikiRemoveHeaderLevel", { noremap = false })

-- Terminal mappings
-- TODO: Could use <Leader>o prefix for open
wk.add({
    { "<Leader>t", group = "terminal" },
    { "<Leader>tt", ":terminal<CR>i", mode = "n", noremap = true, desc = "Open terminal" },
    { "<Leader>ts", ":rightbelow new<CR>:terminal<CR>i", mode = "n",  noremap = true, desc = "Open terminal in split" },
})
vim.cmd [[ tnoremap <Esc> <C-\><C-n> ]]
vim.keymap.set("t", "<C-v><Esc>", "<Esc>", { noremap = true })
