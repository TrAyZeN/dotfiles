if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Directory for plugins
call plug#begin('~/.vim/plugged')

" Vim theme
"Plug 'levelone/tequila-sunrise.vim'
" Plug 'wdhg/dragon-energy'
Plug 'morhetz/gruvbox'

" Vim airline
Plug 'vim-airline/vim-airline'

" Intialize plugin system
call plug#end()

colorscheme gruvbox
set bg=dark

" vim airline config
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

" tab size
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab

" character list
set list
set listchars=tab:..,trail:~

" max line length
set textwidth=80
set colorcolumn=80
highlight ColorColumn ctermbg=red guibg=green

" disable auto indent
filetype indent off

" enable syntax highlighting
syntax on

set spelllang=en_us
set spell

set encoding=utf8

" display line numbers on the left
set number

" show matching parenthesis
set showmatch

