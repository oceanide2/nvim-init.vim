" vim-plug
call plug#begin('~/.vim/plugged')
Plug 'connorholyday/vim-snazzy'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'junegunn/fzf.vim'
call plug#end()

" colorscheme
set t_Co=256
syntax on
colorscheme snazzy

" Leader shortcuts
let mapleader=','   " change mapleader to comma

" spaces & tabs
set tabstop=4       " number of visual spaces per tab
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces when indenting with >> and <<
set expandtab       " covert tab to spaces

" UI config
set number          " show line number
set cursorline      " hightlight current line
set showmatch       " hightlight matching [{()}]
set showcmd         " show command in bottom bar
set laststatus=2    " turn on bottom bar

" Misc
set backspace=2     " set backspace=indent,eol,start
set ignorecase      " make searches case-insensitive
set nobackup        " don't keep a backup files
set noundofile      " disable persistence undo
set history=1000    " set how many lines of history to remember

" switch between split window easily
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l

" autocmd
autocmd BufWritePre * %s/\s\+$//e
autocmd FileType html setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
autocmd FileType css setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
autocmd FileType javascript setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
autocmd FileType javascriptreact setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

" vim-airline
let g:airline#extensions#tabline#enabled=1  " turn on buffer list
let g:airline_theme='hybrid'
nnoremap <leader>q :bp<CR>
nnoremap <leader>w :bn<CR>

" vim-indent-guides
let g:indentguides_spacechar = '┆'
let g:indentguides_tabchar = '|'
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

" fzf
nnoremap <C-p> :Files<CR>
