lua<<EOF

require('user.plugins')
require('user.settings')
require('user.keymap')

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
