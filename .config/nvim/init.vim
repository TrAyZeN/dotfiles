call plug#begin()
" Movement speed
Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-vinegar'

" Commenting made easy
Plug 'preservim/nerdcommenter'

" Swag stuff
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Clock is ticking
Plug 'wakatime/vim-wakatime'

" Bearded vim user fear
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

colorscheme gruvbox
set bg=dark

" Indentation
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
syntax on
set showmatch " show matching parenthesis
set list
set listchars=tab:..,trail:~

" disable text format when
" - hitting <Enter> in Insert mode
" - hitting 'o' or 'O' in Normal mode
autocmd FileType * setlocal formatoptions-=ro

" Command completion
set wildmenu
set wildmode=longest:full,full

set encoding=utf8

" Auto load file when it has been changed outside of vim
set autoread

set noswapfile

filetype plugin on

let mapleader = ";"

" Plugin configuration
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

