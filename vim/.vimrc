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

" Set tab width
set shiftwidth=4
set tabstop=4
set softtabstop=4

" Use spaces instead of tabs
set expandtab

" Disable line wrap
set nowrap

" Avoid wrap in the middle of words
set linebreak
set nolist

" Show Status Bar
set laststatus=2
set statusline=%f\ %m%r%w\ %=\ [%{&filetype}]\ [%l/%L,%c]\ %p%%

" Show vertical guide ruler
set colorcolumn=80

" Disable hard wrapping
set textwidth=80

" Auto-wrap while typing
 set formatoptions+=t

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
