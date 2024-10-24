" Sets the default vim settings.
source \$VIMRUNTIME/defaults.vim

" Use UTF8 encoding
set encoding=utf-8

" Show line numbers
set number

" Enable syntax highlighting
syntax on

" Color scheme
"colorscheme distinguished

" Hide intro menu
"set shortmess=a
"set shortmess+=I

" Enable file type detection
"filetype on

" Show filetype
"set filetype

" Highlight current line
"set cursorline

" Set tab width
set shiftwidth=4
set tabstop=4
set softtabstop=4

" Use spaces instead of tabs
set expandtab

" Disable line wrap
set nowrap

" Status Bar
set ruler

" Show character column limit
set colorcolumn=80,100
highlight ColorColumn guibg=Black
highlight ColorColumn ctermbg=0

" Enable soft wrapping at the edge of the screen
" set softwrap

" Avoid wrap in the middle of words
set linebreak
set nolist

" Disable hard wrapping
set textwidth=0

" Set cursor control keys
set whichwrap+=<,>,h,l

" Enable hard wrapping for markdown files
augroup WrapMarkdown
    autocmd!
    autocmd FileType md setlocal wrap
augroup END

" Enable auto-indentation
set autoindent

" Search is not case-sensitive
set ignorecase

" Hide formatting in markdown
set conceallevel=2

" Don't use swapfiles
set noswapfile
