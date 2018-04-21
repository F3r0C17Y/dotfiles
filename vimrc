" Import plugins through pathogen
execute pathogen#infect()

" enable syntax highlighting
syntax on
filetype plugin indent on
filetype plugin on

set t_Co=256
set background=dark
colorscheme desert

"set lazyredraw              "dont redraw while execute macro (could lead to errors with airline)
set nocompatible            "dont use vi compatiblility mode
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

"set colorcolumn=81
"execute "set colorcolumn=" . join(range(81,335), ',')
"highlight ColorColumn ctermbg=DarkGrey ctermfg=DarkRed


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


" Filetype-specific formatting
au FileType c,cpp,h,hpp set formatoptions+=ro "foldmethod=syntax
au FileType c set omnifunc=ccomplete#Complete
au FileType make set noexpandtab shiftwidth=4
" au Syntax {cpp,c,idl} runtime syntax/doxygen.vim
au FileType vim setlocal foldmethod=marker

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
let g:airline_theme = 'angr'

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
nmap <F7> :NERDTreeToggle<CR>

" Tagbar
nmap <F8> :TagbarToggle<CR>


" OmniCompletion
set omnifunc=syntaxcomplete#Complete
" Configure menu behavior
" http://vim.wikia.com/wiki/VimTip1386
set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" Use Ctrl+Space for omni-completion
" http://stackoverflow.com/questions/510503/ctrlspace-for-omni-and-keyword-completion-in-vim
inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
  \ "\<lt>C-n>" :
  \ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
  \ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
  \ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
imap <C-@> <C-Space>

" Popup menu hightLight Group
highlight Pmenu     ctermbg=166 ctermfg=0    guibg=LightGray
highlight PmenuSel  ctermbg=136  ctermfg=0    guibg=DarkBlue      guifg=White
highlight PmenuSbar ctermbg=178  ctermfg=0    guibg=DarkOrange    guifg=White
highlight PmenuThumb ctermbg=178 ctermfg=0    guibg=Black

" Enable global scope search
let OmniCpp_GlobalScopeSearch = 1
" Show function parameters
let OmniCpp_ShowPrototypeInAbbr = 1
" Show access information in pop-up menu
let OmniCpp_ShowAccess = 1
" Auto complete after '.'
let OmniCpp_MayCompleteDot = 1
" Auto complete after '->'
let OmniCpp_MayCompleteArrow = 1
" Auto complete after '::'
let OmniCpp_MayCompleteScope = 0
" Don't select first item in pop-up menu
let OmniCpp_SelectFirstItem = 0

let OmniCpp_NamespaceSearch = 1
let OmniCpp_DisplayMode = 1
let OmniCpp_ShowScopeInAbbr = 0
let OmniCpp_DefaultNamespaces = ["std"]

" ExtraWhitespace
highlight ExtraWhitespace ctermbg=red

