if exists('g:loaded_install') | finish | endif
let g:loaded_install = 1
set nocompatible " uses line continuation and other modern goodies

let s:vim_plug_vim = '~/.vim/autoload/plug.vim'
let s:vim_plug_url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
let install#vim_plug_vim = s:vim_plug_vim

let s:post_install_cmds = []

function install#all()
  let g:invoked_install = 1
  call s:install_vim_plug()
endfunction

function install#post_install()
  if exists('g:invoked_install')
    while len(s:post_install_cmds) > 0
      execute(remove(s:post_install_cmds, 0))
    endwhile
  endif
endfunction

function s:install_vim_plug()
  if empty(glob(s:vim_plug_vim))
    let l:curl = [
          \ 'curl',
          \ '--silent',
          \ '--show-error',
          \ '--fail',
          \ '--location',
          \ '--output', s:vim_plug_vim,
          \ '"' . s:vim_plug_url . '"']
    let l:cmd = join(l:curl, ' ')
    let l:output = system(l:cmd . ' 2>&1')

    if v:shell_error
      echomsg 'Error downloading vim-plug: ' . l:output
      return 0
    endif

    call add(s:post_install_cmds, 'if exists("g:loaded_plug") | PlugInstall | endif')

    return 1
  endif
endfunction
