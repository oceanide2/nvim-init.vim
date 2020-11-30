" leader shortcuts
let mapleader=' '   " change mapleader to space

" edit/source vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

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

Plug 'junegunn/rainbow_parentheses.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    nnoremap <silent> <leader>fb :Buffers<CR>
    nnoremap <silent> <leader>ff :Files<CR>
    nnoremap <silent> <leader>rg :Rg<CR>
    nnoremap <silent> <leader>f/ :BLines<CR>
    nnoremap <silent> <leader>fc :Commits<CR>
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
Plug 'junegunn/vim-slash'
Plug 'preservim/nerdtree'
    let g:NERDTreeShowHidden = 1
    let g:NERDTreeMinimalUI = 1
    let g:NERDTreeIgnore = []
    let g:NERDTreeStatusline = ''
    " Automaticaly close nvim if NERDTree is only thing left open
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    " Toggle
    nnoremap <silent> <leader>ne :NERDTreeToggle<CR>

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
    let g:coc_global_extensions = [
        \ 'coc-emmet',
        \ 'coc-css',
        \ 'coc-html',
        \ 'coc-json',
        \ 'coc-eslint',
        \ 'coc-tsserver',
        \ 'coc-highlight',
        \]

    " Use tab for trigger completion with characters ahead and navigate.
    " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
    " other plugin before putting this into your config.
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Use <c-space> to trigger completion.
    if has('nvim')
      inoremap <silent><expr> <c-space> coc#refresh()
    else
      inoremap <silent><expr> <c-@> coc#refresh()
    endif

    " Make <CR> auto-select the first completion item and notify coc.nvim to
    " format on enter, <cr> could be remapped by other vim plugin
    inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                                  \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

    " GoTo code navigation.
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)
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

" search
" search for word under the cursor
nnoremap <leader>/ "fyiw :/<c-r>f<cr>
set ignorecase      " make searches case-insensitive

" Misc
set backspace=2     " set backspace=indent,eol,start
set nobackup        " don't keep a backup files
set noundofile      " disable persistence undo
set history=1000    " set how many lines of history to remember
set updatetime=300  " set updatetime

" switch between split window easily
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l

" autocmd
autocmd BufWritePre * %s/\s\+$//e
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear
autocmd FileType json setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
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
nnoremap <leader>rt :call OpenTerminal()<CR>
