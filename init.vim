"
" init.vim
"

" using vim-plug
call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-commentary'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'
Plug 'dense-analysis/ale'

Plug 'tpope/vim-endwise'
Plug 'rstacruz/vim-closer'

call plug#end()

set number hidden
hi LineNr ctermfg=8

tnoremap <Esc> <C-\><C-n>


let mapleader=" "

source ~/.config/nvim/cocrc.vim
