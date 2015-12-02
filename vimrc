" Import plugins through pathogen
execute pathogen#infect()

" enable syntax highlighting
syntax on
filetype plugin indent on

set background=dark
colorscheme desert 

"set lazyredraw              "dont redraw while execute macro
set nocompatible
set hidden
set wildmenu
set showcmd
set hlsearch                " enable highlight search
set laststatus=2
set cmdheight=2             " commandline height
set number
set notimeout ttimeout ttimeoutlen=200
set ignorecase
set smartcase
set backspace=indent,eol,start
set ruler                   "show current position
set confirm
set visualbell
set t_vb=
set showmatch               "show matching bracets



if has('gui_running')
    " GUI Vim
    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10   
else
    " Console Vim
    set mouse=a     "Mouse support
    " Transparent console vim background
    hi Normal ctermbg=none
endif

"""""""""""""""""""""""""""""""""""""
" identation
"""""""""""""""""""""""""""""""""""""
set autoindent
set nostartofline

set shiftwidth=4
set softtabstop=4
set expandtab
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keymappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <C-L> :nohl<CR><C-L>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN Configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""
" vim-airline
"""""""""""""""""""""""""""""""""""""
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline_theme = 'powerlineish'

" unicode symbols
"let g:airline_left_sep = '»'
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '«'
"let g:airline_right_sep = '◀'
"let g:airline_symbols.linenr = '␊'
"let g:airline_symbols.linenr = '␤'
"let g:airline_symbols.linenr = '¶'
"let g:airline_symbols.branch = '⎇'
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'
"let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
"let g:airline_left_sep = ''
"let g:airline_left_alt_sep = ''
"let g:airline_right_sep = ''
"let g:airline_right_alt_sep = ''
"let g:airline_symbols.branch = ''
"let g:airline_symbols.readonly = ''
"let g:airline_symbols.linenr = ''

" NERDTree
:nnoremap <leader>n :NERDTreeToggle<CR>

