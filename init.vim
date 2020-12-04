" leader shortcuts
let mapleader=' '   " change mapleader to space

" edit/source vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" remap escape to jk and disable escape
inoremap jk <esc>
inoremap <esc> <nop>

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

  au! FileType fzf tunmap <buffer> <Esc>

Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-slash'
Plug 'preservim/nerdtree'
    let g:NERDTreeShowHidden = 1
    let g:NERDTreeMinimalUI = 1
    let g:NERDTreeIgnore = []
    let g:NERDTreeStatusline = ''
    let g:NERDTreeGitStatusWithFlags = 1
    let g:NERDTreeIgnore = ['^node_modules$']
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

    set hidden

    " don't give |ins-completion-menu\ messages
    set shortmess+=c

    " always show signcolumns
    set signcolumn=yes

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

    " Use `[g` and `]g` to navigate diagnostics
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

    " GoTo code navigation.
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Use K to show documentation in preview window
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction

    " Highlight symbol under cursor on CursorHold
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " Remap for rename current word
    nmap <F2> <Plug>(coc-rename)

    " Remap for format selected region
    xmap <leader>f  <Plug>(coc-format-selected)
    nmap <leader>f  <Plug>(coc-format-selected)

    augroup mygroup
      autocmd!
      " Setup formatexpr specified filetype(s).
      autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
      " Update signature help on jump placeholder
      autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end

    " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
    xmap <leader>a  <Plug>(coc-codeaction-selected)
    nmap <leader>a  <Plug>(coc-codeaction-selected)

    " Remap for do codeAction of current line
    nmap <leader>ac  <Plug>(coc-codeaction)
    " Fix autofix problem of current line
    nmap <leader>qf  <Plug>(coc-fix-current)

    " Create mappings for function text object, requires document symbols feature of languageserver.
    xmap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap if <Plug>(coc-funcobj-i)
    omap af <Plug>(coc-funcobj-a)

    " Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
    nmap <silent> <C-d> <Plug>(coc-range-select)
    xmap <silent> <C-d> <Plug>(coc-range-select)

    " Use `:Format` to format current buffer
    command! -nargs=0 Format :call CocAction('format')

    " Use `:Fold` to fold current buffer
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)

    " use `:OR` for organize import of current buffer
    command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

    " Add status line support, for integration with other plugin, checkout `:h coc-status`
    set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

    " Using CocList
    " Show all diagnostics
    nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
    " Manage extensions
    nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
    " Show commands
    nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
    " Find symbol of current document
    nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
    " Search workspace symbols
    nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
    " Do default action for next item.
    nnoremap <silent> <space>j  :<C-u>CocNext<CR>
    " Do default action for previous item.
    nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
    " Resume latest coc list
    nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
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
set colorcolumn=80  " set mark for column 80
set mouse=a         " enable mouse

" switch between split window easily
tnoremap <C-j> <C-\><C-n><C-W>j
tnoremap <C-k> <C-\><C-n><C-W>k
tnoremap <C-h> <C-\><C-n><C-W>h
tnoremap <C-l> <C-\><C-n><C-W>l
inoremap <C-j> <C-\><C-n><C-W>j
inoremap <C-k> <C-\><C-n><C-W>k
inoremap <C-h> <C-\><C-n><C-W>h
inoremap <C-l> <C-\><C-n><C-W>l
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" autocmd
augroup vimrc_autocmd
    autocmd!
    autocmd BufWritePre * %s/\s\+$//e
    autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
    autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear
    autocmd! FileType json setlocal ts=2 sts=2 sw=2 et
    autocmd! FileType html setlocal ts=2 sts=2 sw=2 et
    autocmd! FileType css setlocal ts=2 sts=2 sw=2 et
    autocmd! FileType javascript setlocal ts=2 sts=2 sw=2 et
    autocmd! FileType javascriptreact setlocal ts=2 sts=2 sw=2 et
    autocmd! FileType * setlocal formatoptions-=cro
augroup END

" open nvim built-in terminal
set splitright
set splitbelow
" turn terminal to normal mode with escape
au! TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif

function! OpenTerminal()
    split term://zsh
    resize 15
endfunction
nnoremap <leader>j :call OpenTerminal()<CR>
