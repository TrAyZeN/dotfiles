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

" Fasto file opening
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-projectionist'

" Stop typing same things all day
Plug 'SirVer/ultisnips'

" More text objects
Plug 'wellle/targets.vim'

Plug 'igankevich/mesonic'

Plug 'pechorin/any-jump.vim'

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

autocmd Filetype json,md,toml,yaml,html setlocal ts=2 sw=2

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

" Auto format with clang format
" From https://vi.stackexchange.com/questions/21102/how-to-clang-format-the-current-buffer-on-save
function FormatBuffer()
  if &modified && !empty(findfile('.clang-format', expand('%:p:h') . ';'))
    let cursor_pos = getpos('.')
    :%!clang-format
    call setpos('.', cursor_pos)
  endif
endfunction

autocmd BufWritePre *.h,*.hpp,*.c,*.cc,*.cpp,*.vert,*.frag :call FormatBuffer()

let $MANSECT="2:3:1:8:5:4:9:6:7"

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
nnoremap <Leader>fR :Rename<space>
nnoremap <Leader>fm :Chmod<space>
nnoremap <Leader>fa :A<CR>
nnoremap <Leader>ff :RipGrep<CR>
nnoremap <Leader>fr :History<CR>

" Buffer mappings
nnoremap <Leader>bo :%bd <bar> e#<CR>

nnoremap <Leader>s :exec "vimgrep /" . expand("<cword>") . "/g src/**/*.c"<CR>:copen<CR>

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
let g:vimwiki_global_ext = 0

let g:ctrlp_map = '<Leader>p'
set wildignore+=*.so,*.o
let g:ctrlp_custom_ignore = {
            \ 'dir': '\v[\/]\.(git|hg|svn)$',
            \ 'file': '\v\.(o|so)$',
            \ }

let g:projectionist_heuristics = {
            \     "src/**/*.c": {
            \         "src/*.c": {
            \             "alternate": "src/{}.h",
            \             "type": "source"
            \         },
            \         "src/*.h": {
            \             "alternate": "src/{}.c",
            \             "type": "header"
            \         }
            \     }
            \ }

let g:fzf_preview_window = []
let g:fzf_layout = { 'down': '30%' }

command! -bang -nargs=* RipGrep
            \ call fzf#run(fzf#wrap({ 'source': 'rg --files --hidden --no-ignore-vcs' }))

    " \ call fzf#vim#grep('rg --files --hidden --no-ignore-vcs', 1,
    " \ fzf#vim#with_preview(), <bang>0)

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

command -nargs=1 -complete=file CreateSrcAndHeader :call CreateSrcAndHeader(<q-args>)
command -nargs=1 -complete=file CreateSrcAndHeaderOpen :call CreateSrcAndHeaderOpen(<q-args>)
command -nargs=1 -complete=file OpenSrcAndHeader :call OpenSrcAndHeader(<q-args>)
command -nargs=0 CreateFunctionDefinition :call CreateFunctionDefinition()
command -nargs=0 OpenAssociatedSrcHeader :call OpenAssociatedSrcHeader

nnoremap <Leader>ch :CreateSrcAndHeaderOpen<Space>
nnoremap <Leader>co :OpenSrcAndHeader<Space>
nnoremap <Leader>cf :CreateFunctionDefinition<CR>

command -nargs=0 Todo :vimgrep /TODO/gj src/**/*.[ch] | copen
