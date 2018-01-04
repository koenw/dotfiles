call pathogen#infect()      " Call pathogen to enable the plugins in ~/.vim/bundle
call pathogen#helptags()

filetype plugin on          " Enable filetype plugins

set nocompatible

set hidden                  " Allow buffer switching without saving
set backup                  " Make a backup of the file before saving
set backupdir=~/.vim/backup " Directory to write backups to (should exist)
set directory=~/.vim/tmp    " No more .sw[a-z] (swap) files all over the place (should exist)
set history=1000            " Save a lot of history (default is 20)
if has('persistent_undo')
  set undofile              " Use persistent undo file
  set undodir=~/.vim/undo   " Directory to write undo files to (should exist)
  set undolevels=1000       " Maximum number of changes that can be undone
  set undoreload=10000      " Maximum number of lines to save for undo on buffer reload
endif

set tabstop=2               " Number of spaces that equals a tab
set shiftwidth=2            " Number of spaces to shift (e.g. >> and <<) with
set expandtab               " Insert spaces instead of tabs
set autoindent              " Automatically indent to the previous lines' indent level

set visualbell              " Use visual bell instead of a beep
set ttyfast                 " Let vim know we have a fast terminal, regardless of $TERM

set encoding=utf-8          " Set default file encoding to utf-8

"colorscheme solarized       " Use solarized color scheme
colorscheme zenburn
set background=dark         " With a dark background
syntax on                   " Enable syntax highlighting
set relativenumber          " Show relative line numbers from current line (instead of `set nu`)
set number
set cursorline              " Highlight current line
highlight clear SignColumn  " Make 'gutter' background match buffer background
set listchars=tab:▸\ ,eol:¬ " Characters to use for tabs and newlines for `set list`
set laststatus=2            " Always display the powerline statusline
set noshowmode              " Hide the default mode text (e.g. '-- INSERT --') below the status line

" highlight trailing whitespace in red, but not on the line we're typing
highlight TrailingWhitespace ctermbg=red guibg=red
match TrailingWhitespace /\s\+$/
au InsertEnter * match TrailingWhitespace /\s\+\%#\@<!$/
au InsertLeave * match TrailingWhitespace /\s\+$/

if has('gui_running')
  set guioptions-=T         " Remove the toolbar
  set guioptions-=m         " Remove the menubar
  set guioptions-=r         " Remove the scrollbar
endif

if ! has('gui_running')
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=0
  augroup END
endif

set scrolloff=10            " Minimum number of lines to keep visible around cursor
set scrolljump=0            " Number of lines to scroll when cursor leaves screen

set wildmenu                " Show list instead of just completing
set wildmode=list:longest   " Tab completion: list matches, then longest common part

set incsearch               " Search as you type
set ignorecase              " Make search case insensitive
set smartcase               " Don't make search case insensitive if UC present

set spell

let mapleader = ';'         " Set the leader to ';', easy on the hands
noremap <silent> <leader>;  q:
noremap <silent> <leader>e  :NERDTreeFind<CR>
noremap <silent> <C-e>      :NERDTreeToggle<CR>
" Bind <leader>vs to setup a vsplit buffer, scrolling 'below' the current buffer
noremap <silent> <leader>vs :<C-u>let @z=&so<CR>:set so=0 noscb<CR>:bo vs<CR>Ljzt:setl scb<CR><C-w>p:setl scb<CR>:let &so=@z<CR>
" Go down to next row, instead of next line
nnoremap j gj
" Go up to previous row, instead of previous line
nnoremap k gk
" Bind Y to yank from the cursor to the end of the line
nnoremap Y y$

if has("autocmd")
  " Restore cursor position
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  " Set filetype to arduino on .pde files
  autocmd! BufNewFile,BufRead *.pde setlocal ft=arduino

  " Change tab settings some file types
  autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4
  autocmd FileType rust setlocal tabstop=4 shiftwidth=4 softtabstop=4

  " Enable omni completion.
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
  autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
endif

" Keep wrapped lines indented
if v:version > 704 || v:version == 704 && has("patch338")
  set breakindent
endif

" key bindings for fugitive
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit -v<CR>
nnoremap <silent> <leader>gb :Gblame<CR>

" key bindings for tabularize
nnoremap <silent> <leader>a= :Tabularize /=<CR>
vnoremap <silent> <leader>a= :Tabularize /=<CR>
nnoremap <silent> <leader>a: :Tabularize /:<CR>
vnoremap <silent> <leader>a: :Tabularize /:<CR>
nnoremap <silent> <leader>a<Bar> :Tabularize /<Bar><CR>
vnoremap <silent> <leader>a<Bar> :Tabularize /<Bar><CR>

" Airline
let g:airline_powerline_fonts               = 1   " Try to use powerline fonts
let g:airline#extensions#branch#enabled     = 1   " fugitive integration
let g:airline#extensions#syntastic#enabled  = 1   " syntastic integration
let g:airline#extensions#hunks#enabled      = 1   " show a summary of changed hunks
let g:airline#extensions#hunks#non_zero_only = 0  " show only non-zero hunks
let g:airline#extensions#hunks#hunk_symbols = ['+', '~', '-'] " hunk count symbols
let g:airline_theme = 'zenburn'

" Syntastic
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']

" vim-go
" Enable goimports to automatically insert import paths instead of gofmt
let g:go_fmt_command = "goimports"
" More syntax highlighting
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" rust.vim
let g:rustfmt_autosave = 1  " automatically run `rustfmt` on save

" LanguageClient-neovim
set runtimepath+=~/.vim/bundle/LanguageClient-neovim
" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['javascript-typescript-stdio'],
    \ }

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
nnoremap <silent> S :call LanguageClient_textDocument_documentSymbol()<CR>
" end LanguageClient-neovim

" YouCompleteMe extra_conf whitelist/blacklist
let g:ycm_extra_conf_globlist = ['~/dev/*','~/sync/dev/*','!~/*']

" vim-bufferline
" Fix annoying redundant echo beneath statusline
let g:bufferline_echo = 0
