# bdd's Vim #
Berk D. Demir's Vim configuration.

## Version ##
Target version is Vi IMproved 8.0 on macOS Sierra (10.12)
Things will probably work with somewhat older and also newer versions
of Vim on other operatings systems.

## Installation ##
### Fix your xterm-256color first ###
macOS Sierra still ships with a busted terminfo for `xterm-256color`, missing escape codes for
italics; although Terminal.app supports them.

Just modify it instead of creating a '-italic' variant.

```
% export TERM=xterm-256color
% {infocmp && echo -e '\tsitm=\E[3m, ritm=\E[23m,'} > ~/.$TERM-patched.terminfo && tic ~/.$TERM-patched.terminfo
```

Tmux 2.3 with `set -g default-terminal xterm-256color` works as expected after fixing terminfo.  No
other configuration needed.

### Install vim-plug and trigger it to install plugins
Plugins are managed by `vim-plug`. It also upgrades itself. For this reason, it's not checked in to
the repository but a helper script bootstaps the latest version from GitHub to `autoload/plug.vim`.

Launch Vim as:

```
% vim --cmd 'call install#all()'
```
