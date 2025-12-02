" Sets the default vim settings.
source \$VIMRUNTIME/defaults.vim

" Use UTF8 encoding
set encoding=utf-8

" Show line number on current line
" relative line numbers on others
set number relativenumber

" Enable syntax highlighting
syntax on
set synmaxcol=200

" Use comma as local leader key
let mapleader = ","

" Show command in bottom right
set showcmd

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX) && getenv('TERM_PROGRAM') != 'Apple_Terminal')
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" Color scheme
colorscheme gruvbox

" Enable file type detection
filetype on

" Highlight current line
set cursorline

" Use 4 spaces for indentation
" instead of tabs
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab

" Enable line wrapping (soft visual only)
set number
set textwidth=0
set wrapmargin=0
set wrap
set linebreak
set nolist
set columns=90
set colorcolumn=80

" Show Status Bar
set laststatus=2
set statusline=%f\ Filetype:\ %y\ %m%r%w\ %=\ [%{&filetype}]\ [Line\ %l/%L,\ %c]\ %p%%

" Auto-wrap while typing
 set formatoptions+=t

" Set cursor control keys
set whichwrap+=<,>,h,l


" Enable auto-indentation
set autoindent

" Search is not case-sensitive
set ignorecase

" Hide formatting in markdown
set conceallevel=2

" Don't use swapfiles
set noswapfile
