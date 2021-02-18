call plug#begin()
" Movement speed
Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-vinegar'

" Swag stuff
Plug 'morhetz/gruvbox'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'

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

" Plugin configuration
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:loaded_clipboard_provider = 1



