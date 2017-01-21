if !empty(glob(install#vim_plug_vim))
  call plug#begin()

  Plug 'mileszs/ack.vim'
  if executable('rg')
    let g:ackprg = 'rg --smart-case --vimgrep'
  elseif executable('ag')
    let g:ackprg = 'ag --vimgrep'
  endif

  Plug 'tpope/vim-rsi'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-fugitive'
  Plug 'scrooloose/nerdcommenter'
  Plug 'scrooloose/nerdtree'
  Plug 'fatih/vim-go'
  Plug 'godlygeek/tabular'

  Plug 'scrooloose/syntastic'
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*
  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 0

  let g:homebrew_fzf = '/usr/local/opt/fzf'
  if !empty(glob(g:homebrew_fzf))
    Plug g:homebrew_fzf
  else
    Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --bin'}
  endif
  Plug 'junegunn/fzf.vim'

  call plug#end()
endif

" Terminal
if exists('$TMUX')
  " Disable Background Control Erase (BCE)
  set t_ut=

  " 'xterm2' type supports dragging events, used when resizing windows.
  " Although Tmux supports it, Vim sets the value to 'xterm'.
  set ttymouse=xterm2
endif

if has('mouse')
  set mouse=a
endif

" Look and feel
set statusline=[%n]\ %<%F\ %m%r%w%y%=\ (%l,%c)\ %P\ of\ %L
if has('syntax')
  syntax on
  set background=dark
  colorscheme noclown
endif

" Enable file type detection with loading plugins & indent by file type.
filetype plugin indent on

" Behavior
set hidden  " don't close but hide the buffer when dismissed
set splitbelow  " new window below when `split`
set splitright  " new window right when `vsplit`
set visualbell  " don't beep! give me a visual bell.
set autowrite  " automatically save before :next, :make, :suspend
set backspace=indent,eol,start  " backspace over everything
set showmatch  " jump to matching bracket briefly
set encoding=utf-8

set expandtab  " spaces over tabs for indentation
set softtabstop=2  " without wasting to much screen estate
set shiftwidth=2  " shift equally to indendation
set tabstop=8  " tabs are 8 chars for a good reason, keep it that way
set autoindent  " always-be-indenting
set copyindent  " copy the existing indenting behavior of file

" By default do not persist undo history but move storage under ~/.vim for the
" cases undo persistence might have been enabled for a particular filetype, etc.
set noundofile undodir=~/.vim/.undo/

" Command and search pattern history
set history=1000

" Searching
set ignorecase smartcase  " case insensitive search if there are no capital letters.
set incsearch  " incrementally move to match and highlight
set hlsearch  " highlight previous search pattern

set relativenumber  " relative line numbers for lines above and below
set showcmd  " show last command
set shortmess=a  " a=all, use all abbrv possible in messages.
set laststatus=2  " 2=always
set lazyredraw  " redraw only when needed
set ttyfast  " send more chars to tty to redraw.
set scrolloff=5  " scroll edge offset (to keep some context)
set wildmenu wildmode=list:longest
set listchars=tab:▸·,trail:·,extends:#,nbsp:·

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
  au FileType go set nolist noet ts=8 sts=0 sw=0
  au FileType gitconfig set nolist noet ts=8 sts=0 sw=0
  au FileType gitcommit setlocal spell
  au BufEnter *.pxi set ft=pyrex
  au BufEnter BUILD* set ft=python
  au BufEnter TARGET set ft=python
endif

" Key mappings
let mapleader = "\<Space>"

" Normal Mode
nnoremap ; :
nnoremap <Tab> %
nmap <Leader>b :buffer<space>
nmap <Leader><Leader> :buffers<CR>
nmap <Leader>rc :split $MYVIMRC<CR>
nmap <silent> <Leader>/ :nohlsearch<CR>
nmap <C-V>s :echo SyntaxItem()<CR>

" Window Navigation
nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l

" Insert Mode
" Use <CR> to select completion suggestion instead of <C-y>
inoremap <expr> <CR> pumvisible() ? ("\<C-y>") : ("\<CR>")

" Utility functions
function! Preserve(command)
  let l:saved_search = @/
  let l:line = line('.')
  let l:col = col('.')

  execute a:command

  let @/ = l:saved_search
  call cursor(l:line, l:col)
endfunction

function! SyntaxItem()
  " Return the names in syntax identifier chain for the symbol under cursor.
  " Chain is a '->' delimited string of linked syntax identifier names from
  " leaf to root.
  let l:cur_sid = synID(line('.'), col('.'), 1)
  let l:prev_sid = 0
  let l:chain = []

  while l:cur_sid != l:prev_sid
    call add(l:chain, l:cur_sid)
    let l:prev_sid = l:cur_sid
    let l:cur_sid = synIDtrans(l:cur_sid)
  endwhile

  return join(
        \ map(l:chain, 'synIDattr(v:val, "name")'),
        \ '->')
endfunction

" Commands
command! -nargs=0 StripTrailingSpaces call Preserve("%s/\\s\\+$//e")

" Execute post-install hooks
call install#post_install()

" modeline
""" vim: undofile
