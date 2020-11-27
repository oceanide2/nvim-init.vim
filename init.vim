" leader shortcuts
let mapleader=' '   " change mapleader to space

" vim-plug
call plug#begin('~/.vim/plugged')
Plug 'haishanh/night-owl.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
    let g:airline#extensions#tabline#enabled=1  " turn on buffer list
    let g:airline_theme='night_owl'
    nnoremap <leader>q :bp<CR>
    nnoremap <leader>w :bn<CR>

Plug 'nathanaelkane/vim-indent-guides'
    let g:indentguides_spacechar = '┆'
    let g:indentguides_tabchar = '|'
    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_start_level=2
    let g:indent_guides_guide_size=1

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    nnoremap <silent> <leader>b :Buffers<CR>
    nnoremap <silent> <leader>f :Files<CR>
    nnoremap <silent> <leader>rg :Rg<CR>
    nnoremap <silent> <leader>/ :BLines<CR>
    nnoremap <silent> <leader>g :Commits<CR>
    command! -bang -nargs=* Rg
        \ call fzf#vim#grep(
        \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
        \   fzf#vim#with_preview(), <bang>0)

    let g:fzf_action = {
        \ 'ctrl-t': 'tab split',
        \ 'ctrl-s': 'split',
        \ 'ctrl-v': 'vsplit',
        \}

Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
    let g:NERDTreeShowHidden = 1
    let g:NERDTreeMinimalUI = 1
    let g:NERDTreeIgnore = []
    let g:NERDTreeStatusline = ''
    " Automaticaly close nvim if NERDTree is only thing left open
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    " Toggle
    nnoremap <silent> <leader>ne :NERDTreeToggle<CR>

Plug 'preservim/nerdcommenter'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
    let g:coc_global_extensions = ['coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver']
call plug#end()

" colorscheme
set t_Co=256
syntax on
colorscheme night-owl
if (has("termguicolors"))
    set termguicolors
endif

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

" open nvim built-in terminal
set splitright
set splitbelow
" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif

function! OpenTerminal()
    split term://zsh
    resize 10
endfunction
nnoremap <leader>t :call OpenTerminal()<CR>
