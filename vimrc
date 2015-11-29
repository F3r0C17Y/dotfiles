" Import plugins through pathogen
execute pathogen#infect()

" enable syntax highlighting
syntax on

filetype plugin indent on

set compatible
set hidden
set wildmenu
set showcmd
" enable highlight search
set hlsearch

" ignore case
set ignorecase
set smartcase

set backspace=indent,eol,start

"""""""""""""""""""""""""""""""""""""
" identation
"""""""""""""""""""""""""""""""""""""
set autoindent
set nostartofline

set shiftwidth=4
set softtabstop=4
set expandtab

set ruler
set laststatus=2

set confirm

set visualbell
set t_vb=


set mouse=a

set cmdheight=2

set number

set notimeout ttimeout ttimeoutlen=200


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keymappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <C-L> :nohl<CR><C-L>

