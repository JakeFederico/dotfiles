" Use bash as the standard shell, and allow it to source our .bashrc so we get
" all our juicy aliases and paths set up properly
set shell=/bin/bash

" Set up vim for the most incompatible vi experience: ie. let vim stand by its
" name 'Vi IMproved'
set nocompatible
" Setup vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage itself
Plugin 'gmarik/Vundle.vim'

Plugin 'scrooloose/nerdtree' " NERDTree
Plugin 'tomasr/molokai'
"Plugin 'altercation/vim-colors-solarized' " Solarized color
Plugin 'maxbrunsfeld/vim-yankstack' " emacs style kill-ring
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ctrlpvim/ctrlp.vim' " Ctrl P
Plugin 'airblade/vim-gitgutter' " Git gutter
Plugin 'tpope/vim-fugitive' " Git commands
Plugin 'Valloric/YouCompleteMe' " YCM
"Plugin 'rdnetto/YCM-Generator'
"Plugin 'godlygeek/tabular' " Tabularize
"Plugin 'vim-scripts/Conque-GDB' " GDB
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'AndrewRadev/switch.vim'
Plugin 'Raimondi/delimitMate'
Plugin 'rosenfeld/conque-term'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'mbbill/undotree'
Plugin 'tpope/vim-dispatch'
Plugin 'klen/python-mode'
Plugin 'elzr/vim-json'
Plugin 'easymotion/vim-easymotion'

call vundle#end()
filetype plugin indent on

syntax on
set background=dark
colorscheme molokai
set noshowmode

set autoindent                 "use indentation of previous line
"set showcmd                    "show the last ex command
set laststatus=2               "Always display the statusline in all windows
set hidden                     "hide buffers, don't abandon them
set visualbell                 "use visual cue for error
set ttyfast                    "improve screen redrawing
set undofile                   "save undo history to file
"set lazyredraw                 "save some computational power
set splitbelow                 "default split behavior
set splitright                 "default split behavior
set autoread                   "reread files that changed outside vim
"set autowrite                  "auto save when moving away via ^], fe
"set autowriteall               "same, but for :edit and family
set title                      "use a title
"set ignorecase smartcase       "use smart case searching
set cursorline                 "highlight the current line
"set whichwrap=                 "no keys can wrap lines in normal/visual
"set hlsearch incsearch         "highlight as we go
set history=1000               "keep a longer ex history
set undoreload=1000            "keep a longer undo history
set backspace=indent,eol,start "let insert mode backspace be useful
" set showbreak=↪                "put at the start of wrapped lines
"set colorcolumn=+1             "highilight the column after the textwidth value
"set nrformats=octal,hex,alpha  "make ^x and ^a intelligent
set scrolloff=10               "keep at least 10 lines above/below cursor
set virtualedit=block          "Let block visual go past EOL
set list                       "show special chars (below)
"set foldmethod=syntax          "use syntax folding by default
set number                     "enable line numbers by default
set encoding=utf-8
set listchars=
"set listchars=tab:▸\
"set listchars+=extends:❯,precedes:❮
set fileformats=unix,dos,mac
set nrformats-=octal

augroup ALL
  autocmd!

  " Strips file trailing white space, preserving cursor position
  function! StripTrailingWhitespaces()
      let l = line(".")
      let c = col(".")
      %s/\s\+$//e
      call cursor(l, c)
  endfun

  " Clear trailing white spaces
  au BufWrite * call StripTrailingWhitespaces()

  " Save when losing focus
  "au FocusLost * silent! wa

  " Resize splits when the window is resized
  au VimResized * wincmd =

  " Show trailing characters when not in insert mode
  au InsertEnter * :set listchars-=trail:⌴
  au InsertLeave * :set listchars+=trail:⌴

  " Return to the same line when opening a file
  au BufReadPost *
          \ if line("'\"") > 0 && line("'\"") <= line("$") |
          \     execute 'normal! g`"zvzz' |
          \ endif

augroup end

let mapleader = "\\"

" Some of these are overridden by the file-specific augroups
set tabstop=4
set shiftwidth=4
set shiftround
set softtabstop=4
set expandtab
"set wrap
set textwidth=0
set wrapmargin=0

set backup                        " enable backups
set undodir=~/.vim/tmp/undo/     " undo files
set backupdir=~/.vim/tmp/backup/ " backups
set directory=~/.vim/tmp/swap/   " swap files

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

set wildmode=longest,list:longest,full

set wildignore+=*.aux,*.out,*.toc                "LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   "binary images
set wildignore+=*.pyc                            "compiled object files
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest "compiled object files
set wildignore+=*.d,*.su                         "dependency files
set wildignore+=*.spl                            "compiled spelling word lists
set wildignore+=*.sw?                            "Vim swap files
set wildignore+=*~                               "Unix temp files

let g:ctrlp_working_path_mode = 'rw'
let g:ctrlp_by_filename       = 0
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard']
let g:ctrlp_lazy_update = 10
let g:ctrlp_types = ['mru', 'fil']

:command W w
:command Q q
:command Wa wa
:command Qa qa
:command Sh sh
:command Vsp vsplit

map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

map <leader><cr> :NERDTreeToggle<cr>
map <c-m> :NERDTreeFind<cr>
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"
let g:NERDTreeQuitOnOpen=1
nmap - <Plug>yankstack_substitute_older_paste
nmap = <Plug>yankstack_substitute_newer_paste

let g:airline_theme='cool'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
"let g:airline_right_alt_sep = ' '
"let g:airline_right_sep = ' '
"let g:airline_left_alt_sep= ' '
"let g:airline_left_sep = ' '
let g:airline#extensions#tabline#fnamemod = ':t'

nmap + :bn<cr>
nmap _ :bp<cr>
nmap <leader><BS> :bp<cr>:bd #<cr>

let g:ycm_extra_conf_globlist = ['~/firmware/*']
let g:ycm_error_symbol = '-'
let g:ycm_warning_symbol = '-'
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_echo_current_diagnostic = 0
let g:ycm_add_preview_to_completeopt = 0
"let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

nmap gj :YcmCompleter GoTo<cr>
nmap ? :YcmCompleter GetDoc<cr>

let g:UltiSnipsExpandTrigger="<c-l>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

let g:switch_mapping = '<leader>a'
let g:switch_reverse_mapping = '<leader>x'
let g:switch_custom_definitions =
      \ [
      \   ['&&', '||'],
      \   ['== TRUE', '== FALSE'],
      \   ['TRUE', 'FALSE'],
      \   ['!= TRUE', '== TRUE'],
      \   ['!= FALSE', '== FALSE'],
      \   ['pick', 'fixup', 'squash', 'reword', 'edit'],
      \   {
      \     '\v(( +).*\(*)(\(.*\))\)' : '\1\3 ||\r\2())',
      \     '\v(.*) \|\|\n +\(\)\)' : '\1)',
      \     '\v(.*) \&\&\n +\(\)\)' : '\1)',
      \     '\v(.*) \|\|' : '\1 &&',
      \     '\v(.*) \&\&' : '\1 ||',
      \   }
      \ ]

let g:delimitMate_expand_cr = 1

let g:pymode_folding = 0
let g:pymode_lint_checkers = ['pylint']
let g:pymode_trim_whitespaces = 0
let g:pymode_options = 0
let g:pymode_options_max_line_length = 0
let g:pymode_options_colorcolumn = 0
let g:pymode_lint_options_pylint = {'rcfile':"~/pylint.rc"}
let g:pymode_rope_completion = 0
let g:pymode_lint_on_write = 0

nmap <leader>u :UndotreeToggle<cr>
map <leader><c-n> :MultipleCursorsFind
