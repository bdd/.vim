"" Load Pathogen.vim (http://github.com/tpope/vim-pathogen)
" Delegate vim runtime management to Pathogen.
" This way plugins can go into "~/.vim/bundle" into their own directories.
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Enable file type detection with loading plugins & indent by file type.
filetype plugin indent on

" No modelines for a healthy bit of paranoia.
set nomodeline

" Use UTF-8 everywhere.
set encoding=utf-8

" Editing
"""""""""""""
""" Behavior
set backspace=indent,eol,start
""" Tabs
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab smarttab " ts=2 sw=2 sts=2 et sta
set shiftround
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
set title           " set title of the terminal
set shortmess=a     " a=all, use all abbrv possible in messages.
set laststatus=2    " 2=always
set statusline=[%n]\ %<%F\ %m%r%w%y%=\ Ln:\ %l\ Cl:\ %c\ (%P\ of\ %L)
set listchars=tab:▸·,trail:·,extends:#,nbsp:·
set list            " display listchars by default.
set ttyfast         " send more chars to tty to redraw.
set scrolloff=3     " scroll edge offset (to keep some context)
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
"set noswapfile
"set nobackup

if has("syntax")
  syntax on
  colorscheme Tomorrow-Night-Eighties
endif

if has("autocmd")
  au FileType c set sts=4 sw=4 et cindent
  au FileType vim set sts=2 sw=2 et ai tw=80
  au FileType ruby set sts=2 sw=2 et ai tw=80
  au FileType sh set sts=4 sw=4 et ai
  au FileType python,pyrex set sts=4 sw=4 et cindent cinkeys=:,o,O
  au FileType xhtml set sts=2 sw=2 et smartindent
  au FileType scala set sts=2 sw=2 et smartindent
  au FileType java set sts=4 sw=4 et cindent
  au FileType php set sts=4 sw=4 et cindent
  au BufEnter *.pxi set ft=pyrex
endif

" TODO:
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
" Nuke Arrow Keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
"

""" Command Mode
cmap w!! w !sudo tee % >/dev/null
"

""" TODO: Buffer Navigation
""" TODO: Tab Navigation
"""

" Utility functions
function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

if has('gui_running')
  set guioptions=egmt
  set cursorline
  set guifont=Menlo:h13
  colorscheme Tomorrow-Night-Eighties

  highlight SpellBad term=underline gui=undercurl guisp=Red

  " Tab Navigation via Cmd+<N>
  map <silent> <D-1> :tabn 1<cr>
  map <silent> <D-2> :tabn 2<cr>
  map <silent> <D-3> :tabn 3<cr>
  map <silent> <D-4> :tabn 4<cr>
  map <silent> <D-5> :tabn 5<cr>
  map <silent> <D-6> :tabn 6<cr>
  map <silent> <D-7> :tabn 7<cr>
  map <silent> <D-8> :tabn 8<cr>
  map <silent> <D-9> :tabn 9<cr>
endif
