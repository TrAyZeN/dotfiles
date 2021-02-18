if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Directory for plugins
call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'

" Vim airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

" Automatically generates ctags
Plug 'ludovicchabant/vim-gutentags'

Plug 'tpope/vim-vinegar'

Plug 'wakatime/vim-wakatime'

" Intialize plugin system
call plug#end()

colorscheme gruvbox
set bg=dark

" tab size
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab

filetype plugin indent on

set autoindent
set smartindent

" character list
set list
set listchars=tab:..,trail:~

" max line length
set textwidth=80
set colorcolumn=80
highlight ColorColumn ctermbg=red guibg=green

" enable syntax highlighting
syntax on

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

