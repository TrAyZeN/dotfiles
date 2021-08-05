call plug#begin()
" Movement speed
Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-vinegar'

" Surround things
Plug 'tpope/vim-surround'

" Commenting made easy
Plug 'preservim/nerdcommenter'

" Swag stuff
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" git gud
Plug 'tpope/vim-fugitive'

" Clock is ticking
Plug 'wakatime/vim-wakatime'

" Language syntax
Plug 'cespare/vim-toml'
Plug 'tikhomirov/vim-glsl'
Plug 'rust-lang/rust.vim'
Plug 'elixir-editors/vim-elixir'

" Bearded vim user fear
Plug 'neoclide/coc.nvim', {'branch': 'release'}

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
set listchars=tab:..,trail:~
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

autocmd FileType c,cc,cpp setlocal path+=/usr/include include &

" From https://www.reddit.com/r/neovim/comments/f0qx2y/automatically_reload_file_if_contents_changed/fgxa0f8?utm_source=share&utm_medium=web2x&context=3
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
autocmd FileChangedShellPost *
        \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

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

let mapleader = ";"

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

