if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Directory for plugins
call plug#begin('~/.vim/plugged')

" Movement speed
Plug 'ludovicchabant/vim-gutentags'
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

" Read man pages inside vim
Plug 'vim-utils/vim-man'

" Manage personal wiki
Plug 'vimwiki/vimwiki'

" UNIX helpers
" rename file with :Rename
Plug 'tpope/vim-eunuch'

" Show registers content
Plug 'junegunn/vim-peekaboo'

" Intialize plugin system
call plug#end()

colorscheme gruvbox
set bg=dark

"""""""""""""""""""""""
" Indentation and tabs
"""""""""""""""""""""""
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set autoindent
set smartindent

autocmd Filetype json setlocal ts=2 sw=2

" max line length
set textwidth=80
set colorcolumn=80
highlight ColorColumn ctermbg=red guibg=green

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

set encoding=utf8

" Keep 5 lines below and above the cursor
set scrolloff=5

" Don't redraw when executing macros
set lazyredraw

filetype plugin indent on

" Goodbye trash file
set noswapfile

" Auto load file when it has been changed outside of vim
set autoread

" Enable spell checking
set spelllang=en_us ",fr
set spell

set encoding=utf8

" disable text format when
" - hitting <Enter> in Insert mode
" - hitting 'o' or 'O' in Normal mode
autocmd FileType * setlocal formatoptions-=ro

" display line numbers on the left
set number

" show matching parenthesis
set showmatch
" Command completion
set wildmenu
set wildmode=longest:full,full

" Auto load file when it has been changed outside of vim
set autoread

set noswapfile

" Don't redraw when executing macros
set lazyredraw

" Use shift+k to open man page under the cursor
set keywordprg=:Man

autocmd FileType c,cc,cpp setlocal path+=/usr/include include &

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
nnoremap <Leader>mt :Make check<R>

" fugitive mappings
nnoremap <Leader>gg :Git<CR>
nnoremap <Leader>gb :Git blame<CR>
nnoremap <Leader>gd :Gvdiffsplit<CR>
nnoremap <Leader>ga :Git add %<CR>
nnoremap <Leader>gc :Git commit<CR>

" File mappings
nnoremap <Leader>fr :Rename<space>
nnoremap <Leader>fp :Chmod<space>

" Fix key binding conflict between vim-vinegar and vimwiki
nmap <Nop> <Plug>VimwikiRemoveHeaderLevel

"""""""""""""""""""""""
" Plugins configuration
"""""""""""""""""""""""
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

let g:loaded_clipboard_provider = 1

let g:vim_man_cmd = 'man'

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

let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown',
                        \ 'ext': '.md' }]

function CreateSrcAndHeaderOpen(filename)
    call CreateSrcAndHeader(a:filename)

    silent exec ":e +2 " . a:filename . ".c"
    silent exec ":rightbelow vsplit +4 " . a:filename . ".h"
endfunction

function OpenSrcAndHeader(filename)
    silent exec ":e " . a:filename . ".c"
    silent exec ":rightbelow vsplit " . a:filename . ".h"
endfunction

function CreateSrcAndHeader(filename)
    " TODO: Throw error when the file already exists

    let l:basename = fnamemodify(a:filename, ":t:r")

    call writefile(
        \[
            \"#include \"" . l:basename . ".h\"",
            \"",
        \],
        \a:filename . ".c",
        \"a"
    \)

    call writefile(
        \[
            \"#ifndef " . toupper(l:basename) . "_H_",
            \"#define " . toupper(l:basename) . "_H_",
            \"",
            \"",
            \"",
            \"#endif // " . toupper(l:basename) . "_H_"
        \],
        \a:filename . ".h",
        \"a"
    \)
endfunction

function CreateFunctionDefinition()
    let l:current_line = getline(".")
    let l:src_filename = expand("%:r") . ".c"

    call writefile(
        \[
            \substitute(l:current_line, ";", " {", ""),
            \"    ",
            \"}"
        \],
        \l:src_filename,
        \"a"
    \)

    exec "e " . l:src_filename
    call cursor(line("$") - 1, "4")
endfunction

function OpenAssociatedSrcHeader()
    let l:extension = expand("%:e")

    if l:extension == "h"
        silent exec "topleft sp %<.c"
    elseif l:extension == "c"
        silent exec "rightbelow sp %<.h"
    else
        " TODO: Error
    endif
endfunction

command -nargs=1 -complete=file CreateSrcAndHeader :call CreateSrcAndHeader(<q-args>)
command -nargs=1 -complete=file CreateSrcAndHeaderOpen :call CreateSrcAndHeaderOpen(<q-args>)
command -nargs=1 -complete=file OpenSrcAndHeader :call OpenSrcAndHeader(<q-args>)
command -nargs=0 CreateFunctionDefinition :call CreateFunctionDefinition()
command -nargs=0 OpenAssociatedSrcHeader :call OpenAssociatedSrcHeader

nnoremap <Leader>ch :CreateSrcAndHeaderOpen<Space>
nnoremap <Leader>co :OpenSrcAndHeader<Space>
nnoremap <Leader>cf :CreateFunctionDefinition<CR>
nnoremap <Leader>ca :OpenAssociatedSrcHeader<CR>

command -nargs=0 Todo :vimgrep /TODO/gj src/**/*.[ch] | copen
