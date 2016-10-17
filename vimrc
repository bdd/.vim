if !empty(glob("~/.vim/autoload/plug.vim"))
call plug#begin()

Plug 'mileszs/ack.vim'
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
  cnoreabbrev ag Ack
endif

Plug 'tpope/vim-rsi'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'

Plug 'scrooloose/syntastic'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"Plug 'junegunn/fzf.vim'

Plug 'chriskempson/tomorrow-theme', { 'rtp': 'vim' }

call plug#end()
endif

" Terminal
set t_ut= " Disable Background Control Erase (BCE)

" Enable file type detection with loading plugins & indent by file type.
filetype plugin indent on

" Use UTF-8 everywhere.
set encoding=utf-8

" Mouse
"""""""
if has('mouse')
  set mouse=a
endif

" Editing
"""""""""""""
""" Behavior
set backspace=indent,eol,start
""" Tabs
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
set smarttab
set shiftround " round indent to multiple of 'shiftwidth'
""" Indentation
set autoindent copyindent
""" Visual Indicators
set showmatch " jump to matching bracket briefly
"

" Folding
"""""""""""""
set foldenable
set foldmethod=marker " Triple-{ fold markers.
" CMDs triggering auto-unfold.
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
"set foldcolumn=2        " Add a fold column.
"

" Searching
"""""""""""""""
set hlsearch " highlight search terms.
set incsearch " incrementally move to match.
set ignorecase smartcase " case insensitive search if there are no capital letters.
"

" Appearance
""""""""""""""""
set cursorline      " highlight current line
set number          " show line number
set relativenumber  " relative line numbers for lines above and below
set showcmd         " show last command
set lazyredraw      " redraw only when needed
set title           " set title of the terminal
set shortmess=a     " a=all, use all abbrv possible in messages.
set laststatus=2    " 2=always
set statusline=[%n]\ %<%F\ %m%r%w%y%=\ (%l,%c)\ %P\ of\ %L
set listchars=tab:▸·,trail:·,extends:#,nbsp:·
set list            " display listchars by default.
set ttyfast         " send more chars to tty to redraw.
set scrolloff=5     " scroll edge offset (to keep some context)
set wildmenu wildmode=list:longest " Command line completion in style!
"

" Annoyances
""""""""""""""""
set visualbell      " don't beep! give me a visual bell.
"

set suffixes=.bak,~,.o,.info,.swp,.obj,.pyc,.class " Ignore these suffixes.
set history=1000
set undolevels=1000
set hidden


if has("autocmd")
  au FileType c set cindent
  au FileType java set cindent
  au FileType php set cindent
  au FileType python,pyrex set ts=4 sts=4 sw=4 cindent cinkeys=:,o,O
  au FileType sh set smartindent
  au FileType vim set smartindent tw=80
  au FileType ruby set smartindent tw=80
  au FileType xhtml set smartindent
  au FileType scala set smartindent
  au FileType make set noexpandtab ts=4 sts=4 sw=4
  au BufEnter *.pxi set ft=pyrex
  au BufEnter BUILD* set ft=python
  au BufEnter TARGET set ft=python
endif

" TODO:
"set noswapfile
"set nobackup
" - Backup file
" - Swap file
" - Undo File

" Key mappings
""""""""""""""""""
let mapleader = ","

""" Normal Mode
nmap <silent><c-c> :nohlsearch<cr>
nmap <leader>b :buffer<space>
nmap <leader><leader> :buffers<cr>
nmap <leader>rc :split $MYVIMRC<cr>
nmap <leader>ts :call Preserve("%s/\\s\\+$//e")<CR>
nnoremap <tab> %
nnoremap ; :
" Window Navigation
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
"

""" Command Mode
cmap w!! w !sudo tee % >/dev/null
"

""" TODO: Buffer Navigation
""" TODO: Tab Navigation
"""

" Utility functions
function! Preserve(command)
  let l:saved_search = @/
  let l:line = line(".")
  let l:col = col(".")

  execute a:command

  let @/ = l:saved_search
  call cursor(l:line, l:col)
endfunction

if has("syntax")
  syntax on
  silent! colorscheme Tomorrow-Night-Eighties
endif
