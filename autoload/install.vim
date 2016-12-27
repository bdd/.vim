if exists('g:loaded_install') | finish | endif
let g:loaded_install = 1
let s:post_install_cmds = []

function install#all()
  let g:invoked_install = 1
  if !s:install_vim_plug() | cquit | endif
endfunction

function install#post_install()
  if exists('g:invoked_install')
    let l:cmds = s:post_install_cmds[:] " make a private copy
    let s:post_install_cmds = []        " truncate script local
    for cmd in l:cmds
      execute(cmd)
    endfor
  endif
endfunction

function s:install_vim_plug()
  let l:src = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  let l:dst = '${HOME}/.vim/autoload/plug.vim'

  if empty(glob(l:dst))
    let l:cmd = 'curl --silent --show-error --fail --location --output ' . l:dst . ' ' . l:src
    let l:output = system(l:cmd . " 2>&1")
    if v:shell_error
      echomsg "Error downloading vim-plug: " . l:output 
      return 0
    endif

    let s:post_install_cmds += ['if exists(''g:loaded_plug'') | PlugInstall | endif']
    return 1
  endif
endfunction
